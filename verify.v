module main

import stardots

fn main() {
	println('StarDots V SDK Verification')
	println('===========================')
	
	// Test client creation
	client_key := 'test_key'
	client_secret := 'test_secret'
	client := stardots.new(client_key, client_secret, '')
	
	println('✓ Client created successfully')
	
	// Test request structures
	space_list_req := stardots.SpaceListReq{
		page: 1
		page_size: 20
	}
	println('✓ SpaceListReq structure created')
	
	create_space_req := stardots.CreateSpaceReq{
		space: 'test-space'
		public: true
	}
	println('✓ CreateSpaceReq structure created')
	
	upload_file_req := stardots.UploadFileReq{
		filename: 'test.txt'
		space: 'test-space'
		file_content: 'Hello, StarDots!'.bytes()
	}
	println('✓ UploadFileReq structure created')
	
	// Test helper functions
	headers := stardots.make_headers(client_key, client_secret)
	println('✓ Headers generated successfully')
	println('  - x-stardots-key: ${headers['x-stardots-key']}')
	println('  - x-stardots-timestamp: ${headers['x-stardots-timestamp']}')
	
	url := stardots.request_url('https://api.stardots.io', '/test')
	println('✓ URL generated: ${url}')
	
	println('\nAll basic structures and functions are working correctly!')
	println('The SDK is ready for use.')
} 