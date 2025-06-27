module stardots

import json
import net.url

// StarDots interface defines all available methods
pub interface IStarDots {
	// get_space_list Get space list data.
	get_space_list(params SpaceListReq) !SpaceListResp
	// create_space Create a new space.
	create_space(params CreateSpaceReq) !CreateSpaceResp
	// delete_space Delete an existing space. Note that you must ensure that there are no files in this space, otherwise the deletion will fail.
	delete_space(params DeleteSpaceReq) !DeleteSpaceResp
	// toggle_space_accessibility Toggle the accessibility of a space.
	toggle_space_accessibility(params ToggleSpaceAccessibilityReq) !ToggleSpaceAccessibilityResp
	// get_space_file_list Get the list of files in the space. The list is sorted in descending order by file upload time.
	get_space_file_list(params SpaceFileListReq) !SpaceFileListResp
	// file_access_ticket Get the access ticket for the file. When the accessibility of the space is private, you need to bring the access ticket to access the files under the space, otherwise the request will be rejected.
	file_access_ticket(params FileAccessTicketReq) !FileAccessTicketResp
	// upload_file Upload the file to the space. Note that this request requires you to initiate the request in the form of a form.
	upload_file(params UploadFileReq) !UploadFileResp
	// delete_file Delete files in the space. This interface supports batch operations.
	delete_file(params DeleteFileReq) !DeleteFileResp
}

// StarDotsImpl implements the IStarDots interface
pub struct StarDotsImpl {
pub:
	endpoint      string
	client_key    string
	client_secret string
}

// new creates a new StarDots client instance
pub fn new(client_key string, client_secret string, endpoint string) IStarDots {
	real_endpoint := if endpoint.len > 0 { endpoint } else { endpoint }
	return StarDotsImpl{
		endpoint: real_endpoint
		client_key: client_key
		client_secret: client_secret
	}
}

// get_space_list implementation
pub fn (v StarDotsImpl) get_space_list(params SpaceListReq) !SpaceListResp {
	mut query_params := url.Values{}
	query_params.add('page', params.page.str())
	query_params.add('pageSize', params.page_size.str())
	
	u := request_url(v.endpoint, '/openapi/space/list?${query_params.encode()}')
	
	body, _ := send_request('GET', u, []u8{}, make_headers(v.client_key, v.client_secret), default_request_timeout) or { return error('Request failed: ${err}') }
	
	mut resp := SpaceListResp{}
	json.decode(SpaceListResp, body.bytestr()) or { return error('JSON decode failed: ${err}') }
	
	return resp
}

// create_space implementation
pub fn (v StarDotsImpl) create_space(params CreateSpaceReq) !CreateSpaceResp {
	js := json.encode(params) or { return error('JSON encode failed: ${err}') }
	u := request_url(v.endpoint, '/openapi/space/create')
	
	body, _ := send_request('PUT', u, js.bytes(), make_headers(v.client_key, v.client_secret), default_request_timeout) or { return error('Request failed: ${err}') }
	
	mut resp := CreateSpaceResp{}
	json.decode(CreateSpaceResp, body.bytestr()) or { return error('JSON decode failed: ${err}') }
	
	return resp
}

// delete_space implementation
pub fn (v StarDotsImpl) delete_space(params DeleteSpaceReq) !DeleteSpaceResp {
	js := json.encode(params) or { return error('JSON encode failed: ${err}') }
	u := request_url(v.endpoint, '/openapi/space/delete')
	
	body, _ := send_request('DELETE', u, js.bytes(), make_headers(v.client_key, v.client_secret), default_request_timeout) or { return error('Request failed: ${err}') }
	
	mut resp := DeleteSpaceResp{}
	json.decode(DeleteSpaceResp, body.bytestr()) or { return error('JSON decode failed: ${err}') }
	
	return resp
}

// toggle_space_accessibility implementation
pub fn (v StarDotsImpl) toggle_space_accessibility(params ToggleSpaceAccessibilityReq) !ToggleSpaceAccessibilityResp {
	js := json.encode(params) or { return error('JSON encode failed: ${err}') }
	u := request_url(v.endpoint, '/openapi/space/accessibility/toggle')
	
	body, _ := send_request('POST', u, js.bytes(), make_headers(v.client_key, v.client_secret), default_request_timeout) or { return error('Request failed: ${err}') }
	
	mut resp := ToggleSpaceAccessibilityResp{}
	json.decode(ToggleSpaceAccessibilityResp, body.bytestr()) or { return error('JSON decode failed: ${err}') }
	
	return resp
}

// get_space_file_list implementation
pub fn (v StarDotsImpl) get_space_file_list(params SpaceFileListReq) !SpaceFileListResp {
	mut query_params := url.Values{}
	query_params.add('page', params.page.str())
	query_params.add('pageSize', params.page_size.str())
	query_params.add('space', params.space)
	
	u := request_url(v.endpoint, '/openapi/file/list?${query_params.encode()}')
	
	body, _ := send_request('GET', u, []u8{}, make_headers(v.client_key, v.client_secret), default_request_timeout) or { return error('Request failed: ${err}') }
	
	mut resp := SpaceFileListResp{}
	json.decode(SpaceFileListResp, body.bytestr()) or { return error('JSON decode failed: ${err}') }
	
	return resp
}

// file_access_ticket implementation
pub fn (v StarDotsImpl) file_access_ticket(params FileAccessTicketReq) !FileAccessTicketResp {
	js := json.encode(params) or { return error('JSON encode failed: ${err}') }
	u := request_url(v.endpoint, '/openapi/file/ticket')
	
	body, _ := send_request('POST', u, js.bytes(), make_headers(v.client_key, v.client_secret), default_request_timeout) or { return error('Request failed: ${err}') }
	
	mut resp := FileAccessTicketResp{}
	json.decode(FileAccessTicketResp, body.bytestr()) or { return error('JSON decode failed: ${err}') }
	
	return resp
}

// upload_file implementation
pub fn (v StarDotsImpl) upload_file(params UploadFileReq) !UploadFileResp {
	u := request_url(v.endpoint, '/openapi/file/upload')
	
	body, _ := send_multipart_request(u, make_headers(v.client_key, v.client_secret), params.filename, params.space, params.file_content, default_request_timeout) or { return error('Request failed: ${err}') }
	
	mut resp := UploadFileResp{}
	json.decode(UploadFileResp, body.bytestr()) or { return error('JSON decode failed: ${err}') }
	
	return resp
}

// delete_file implementation
pub fn (v StarDotsImpl) delete_file(params DeleteFileReq) !DeleteFileResp {
	js := json.encode(params) or { return error('JSON encode failed: ${err}') }
	u := request_url(v.endpoint, '/openapi/file/delete')
	
	body, _ := send_request('DELETE', u, js.bytes(), make_headers(v.client_key, v.client_secret), default_request_timeout) or { return error('Request failed: ${err}') }
	
	mut resp := DeleteFileResp{}
	json.decode(DeleteFileResp, body.bytestr()) or { return error('JSON decode failed: ${err}') }
	
	return resp
} 