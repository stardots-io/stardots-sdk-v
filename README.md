<div align="center">
    <h1><img src="logo.png" alt="logo.png" title="logo.png" width="300" /></h1>
</div> 

# StarDots-SDK-V  

[![V](https://img.shields.io/badge/V-latest-blue.svg)](https://vlang.io/)
[![LICENSE: MIT](https://img.shields.io/github/license/stardots-io/stardots-sdk-v.svg?style=flat)](LICENSE)  

## Introduction  
This project is used to help developers quickly access the StarDots platform and is written in V.

## Requirement  
- V version >= 0.3.0

## Installation  
```bash
# Clone the repository
git clone https://github.com/stardots-io/stardots-sdk-v.git
cd stardots-sdk-v

# Build the project
v build .

# Run tests
v test .
```

## Quick Start
```v
import stardots

fn main() {
	// Initialize the client
	client_key := 'Your client key'
	client_secret := 'Your client secret'
	client := stardots.new(client_key, client_secret, '')

	// Get space list
	space_list_params := stardots.SpaceListReq{
		page: 1
		page_size: 20
	}
	
	space_list := client.get_space_list(space_list_params) or {
		println('Error: ${err}')
		return
	}
	println('Space list: ${space_list}')

	// Create a new space
	create_params := stardots.CreateSpaceReq{
		space: 'my-space'
		public: true
	}
	
	create_result := client.create_space(create_params) or {
		println('Error: ${err}')
		return
	}
	println('Create space result: ${create_result}')
}
```

## Examples
See the [examples directory](examples/) for more detailed usage examples:

- [Basic Usage](examples/basic_usage.v) - Complete example showing all API operations

## API Reference
- `stardots.new(client_key, client_secret, endpoint)` - Create a new client instance
- `client.get_space_list(params)` - Get space list
- `client.create_space(params)` - Create a new space
- `client.delete_space(params)` - Delete an existing space
- `client.toggle_space_accessibility(params)` - Toggle space accessibility
- `client.get_space_file_list(params)` - Get space file list
- `client.file_access_ticket(params)` - Get file access ticket
- `client.upload_file(params)` - Upload file to space
- `client.delete_file(params)` - Delete files from space

## Request/Response Types
- `SpaceListReq` / `SpaceListResp` - Space list operations
- `CreateSpaceReq` / `CreateSpaceResp` - Space creation
- `DeleteSpaceReq` / `DeleteSpaceResp` - Space deletion
- `ToggleSpaceAccessibilityReq` / `ToggleSpaceAccessibilityResp` - Space accessibility toggle
- `SpaceFileListReq` / `SpaceFileListResp` - File list operations
- `FileAccessTicketReq` / `FileAccessTicketResp` - File access ticket
- `UploadFileReq` / `UploadFileResp` - File upload
- `DeleteFileReq` / `DeleteFileResp` - File deletion

## Development
```bash
# Install V language (if not already installed)
# Visit https://vlang.io/ for installation instructions

# Clone the repository
git clone https://github.com/stardots-io/stardots-sdk-v.git
cd stardots-sdk-v

# Run tests
v test .

# Build the project
v build .

# Format code
v fmt .

# Run example
v run examples/basic_usage.v
```

## Documentation
- [API Documentation](https://stardots.io/en/documentation/openapi)
- [StarDots Platform](https://stardots.io)
- [V Language Documentation](https://vlang.io/docs)

## Contributing
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support
- [Issues](https://github.com/stardots-io/stardots-sdk-v/issues)
- [Documentation](https://stardots.io/en/documentation/openapi)
- [StarDots Platform](https://stardots.io) 