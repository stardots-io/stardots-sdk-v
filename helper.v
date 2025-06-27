module stardots

import crypto.md5
import crypto.rand
import encoding.hex
import json
import net.http
import time

// request_url Generate request url.
pub fn request_url(endpoint string, path string) string {
	return '${endpoint}${path}'
}

// make_headers Generate authentication request header.
pub fn make_headers(client_key string, client_secret string) map[string]string {
	ts := time.now().unix().str()
	nonce := '${time.now().unix_time_milli()}${10000 + rand.int_in_range(0, 10000) or { 0 }}'
	need_sign_str := '${ts}|${client_secret}|${nonce}'
	
	hash := md5.sum(need_sign_str.bytes())
	sign := hex.encode(hash).to_upper()
	
	extra_data := {
		'sdk':      'true'
		'language': 'v'
		'version':  sdk_version
		'os':       $if windows { 'windows' } $else $if linux { 'linux' } $else $if macos { 'darwin' } $else { 'unknown' }
		'arch':     $if x64 { 'amd64' } $else $if x32 { '386' } $else $if arm64 { 'arm64' } $else { 'unknown' }
	}
	
	extra_json := json.encode(extra_data) or { '{}' }
	
	return {
		'x-stardots-timestamp': ts
		'x-stardots-nonce':     nonce
		'x-stardots-key':       client_key
		'x-stardots-sign':      sign
		'x-stardots-extra':     extra_json
	}
}

// send_request Send HTTP request
pub fn send_request(method string, url string, json_payload []u8, headers map[string]string, timeout int) !([]u8, int) {
	mut req := http.Request{
		method:  method
		url:     url
		headers: headers
		timeout: timeout
	}
	
	if json_payload.len > 0 {
		req.data = json_payload
		req.headers['Content-Type'] = 'application/json; charset=utf-8'
	}
	
	resp := req.do() or { return error('HTTP request failed: ${err}') }
	
	return resp.body.bytes(), resp.status_code
}

// send_multipart_request Send multipart form request for file upload
pub fn send_multipart_request(url string, headers map[string]string, filename string, space string, file_content []u8, timeout int) !([]u8, int) {
	boundary := '----WebKitFormBoundary${rand.hex(16) or { '0000000000000000' }}'
	
	mut body := []u8{}
	
	// Add file part
	body << '--${boundary}\r\n'.bytes()
	body << 'Content-Disposition: form-data; name="file"; filename="${filename}"\r\n'.bytes()
	body << 'Content-Type: application/octet-stream\r\n\r\n'.bytes()
	body << file_content
	body << '\r\n'.bytes()
	
	// Add space part
	body << '--${boundary}\r\n'.bytes()
	body << 'Content-Disposition: form-data; name="space"\r\n\r\n'.bytes()
	body << space.bytes()
	body << '\r\n'.bytes()
	
	// Add closing boundary
	body << '--${boundary}--\r\n'.bytes()
	
	mut req := http.Request{
		method:  'PUT'
		url:     url
		headers: headers
		data:    body
		timeout: timeout
	}
	
	req.headers['Content-Type'] = 'multipart/form-data; boundary=${boundary}'
	
	resp := req.do() or { return error('HTTP request failed: ${err}') }
	
	return resp.body.bytes(), resp.status_code
} 