module main

import stardots
import testing

fn test_new_client() {
	client_key := 'test_key'
	client_secret := 'test_secret'
	client := stardots.new(client_key, client_secret, '')
	
	assert client is stardots.IStarDots
}

fn test_space_list_req() {
	req := stardots.SpaceListReq{
		page: 1
		page_size: 20
	}
	
	assert req.page == 1
	assert req.page_size == 20
}

fn test_create_space_req() {
	req := stardots.CreateSpaceReq{
		space: 'test-space'
		public: true
	}
	
	assert req.space == 'test-space'
	assert req.public == true
}

fn test_upload_file_req() {
	content := 'test content'.bytes()
	req := stardots.UploadFileReq{
		filename: 'test.txt'
		space: 'test-space'
		file_content: content
	}
	
	assert req.filename == 'test.txt'
	assert req.space == 'test-space'
	assert req.file_content == content
}

fn test_make_headers() {
	client_key := 'test_key'
	client_secret := 'test_secret'
	headers := stardots.make_headers(client_key, client_secret)
	
	assert headers['x-stardots-key'] == client_key
	assert headers['x-stardots-timestamp'].len > 0
	assert headers['x-stardots-nonce'].len > 0
	assert headers['x-stardots-sign'].len > 0
	assert headers['x-stardots-extra'].len > 0
}

fn test_request_url() {
	endpoint := 'https://api.stardots.io'
	path := '/test'
	url := stardots.request_url(endpoint, path)
	
	assert url == '${endpoint}${path}'
} 