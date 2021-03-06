# HPE OneView SDK for Chef

## Build Status 

OV Version | 5.60 | 5.50 | 5.40 | 5.30 |
| ------------- |:-------------:| -------------:| -------------:| -------------:|
SDK Version/Tag | [v3.8.0](https://github.com/HewlettPackard/oneview-chef/releases/tag/v3.8.0) | [v3.7.0](https://github.com/HewlettPackard/oneview-chef/releases/tag/v3.7.0) | [v3.6.0](https://github.com/HewlettPackard/oneview-chef/releases/tag/v3.6.0) | [v3.5.0](https://github.com/HewlettPackard/oneview-chef/releases/tag/v3.5.0) |
Build Status | ![Build status](https://ci.appveyor.com/api/projects/status/u84505l6syp70013?svg=true)| ![Build status](https://ci.appveyor.com/api/projects/status/u84505l6syp70013?svg=true)| ![Build status](https://ci.appveyor.com/api/projects/status/u84505l6syp70013?svg=true)| ![Build status](https://ci.appveyor.com/api/projects/status/u84505l6syp70013?svg=true)|

## Introduction

HPE OneView makes it simple to deploy and manage today’s complex hybrid cloud infrastructure. HPE OneView can help you transform your data center to software-defined, and it supports HPE’s broad portfolio of servers, storage, and networking solutions, ensuring the simple and automated management of your hybrid infrastructure. Software-defined intelligence enables a template-driven approach for deploying, provisioning, updating, and integrating compute, storage, and networking infrastructure.

The HPE OneView Chef SDK enables developers to easily build integrations and scalable solutions with HPE OneView and HPE Image Streamer. You can find the latest supported HPE OneView Chef SDK [here](https://github.com/HewlettPackard/oneview-chef/releases/latest)

## What's New

HPE OneView Chef library extends support of the SDK to OneView REST API version 2200 (OneView v5.50)

Please refer to [notes](https://github.com/HewlettPackard/oneview-chef/blob/master/CHANGELOG.md) for more information on the changes , features supported and issues fixed in this version

## Getting Started 

## Requirements
 - Ruby >= 2.4.1 (We recommend using Ruby >= 2.4.1)
 - Chef >= 12.0  (We recommend using Chef >= 13.12 if possible)

## Installation and Configuration
HPE OneView SDK for Chef can be installed from Source and Docker container installation methods. You can either use a docker container which will have the HPE OneView SDK for Chef installed or perform local installation manually.
	
## Installation

## Docker Setup for oneview-chef
The light weight containerized version of the HPE OneView SDK for Chef is available in the [Docker Store](https://hub.docker.com/r/hewlettpackardenterprise/hpe-oneview-sdk-for-chef). The Docker Store image tag consist of two sections: <sdk_version-OV_version>

```bash
# Download and store a local copy of oneview-chef and
# use it as a Docker image.
$ docker pull hewlettpackardenterprise/hpe-oneview-sdk-for-chef:v3.8.0-OV5.6
# Run docker commands below given, which  will in turn create
# a sh session where you can create files, issue commands and execute the recipes.
$ docker run -it hewlettpackardenterprise/hpe-oneview-sdk-for-chef:v3.8.0-OV5.6 /bin/sh
```

## Local Setup for oneview-chef
Chef SDK dependencies can be installed by bundler.

```bash
# Create a folder cookbooks and clone the chef repo
$ mkdir cookbooks
$ cd cookbooks
$ git clone https://github.com/chef-boneyard/compat_resource
# Clone Chef repo as oneview
$ git clone https://github.com/HewlettPackard/oneview-chef oneview
$ cd oneview
```

### Local installation requires the gem in your Gemfile:
  ```ruby
  gem 'oneview-sdk', '~> 5.18.0'
  ```
### Install Chef Sdk dependencies from Gemfile

```bash
$ bundle install
```

## Usage
The cookbook 'metadata' is not intended to include any recipes instead specifies a dependency which is used by another cookbooks.

```ruby
# my_cookbook/metadata.rb
depends 'oneview', '~> 3.8.0'
```

## Credentials
In order to manage HPE OneView and HPE Synergy Image Streamer resources, you will need to provide authentication credentials. There are 2 ways to do this:

### Environment variables:
  - For HPE OneView: 
    ```bash
    $export ONEVIEWSDK_URL=<ov-endpoint>
    $export ONEVIEWSDK_USER=<ov-user>
    $export ONEVIEWSDK_PASSWORD=<ov-password>
    $export ONEVIEWSDK_SSL_EANBLED=false
    ```

  - For HPE Synergy Image Streamer: 
    ```bash
    $export I3S_URL=<i3s-endpoint>
    ```

### API version
When using the resources a API version will be selected to interact with the resources in each HPE OneView correct API versions. To select the desired one, you may use one of the following methods:

1. Set the resource property `api_version`. See the [Resource Properties](#resource-properties) section below.
2. Set the client parameter `api_version`. If this parameter is set, it will select the required API version based on the client. Notice if you choose to pass the client as an OneviewSDK object, it will have, by default, the api_version set, even if you do not directly specify it.
3. If none of the previous alternatives are set, it defaults to the `node['oneview']['api_version']`. See the [Atributes](#attributes).

Be aware of the precedence of these methods! The higher priority goes to setting the resource property, followed by the client parameter, and at last the node value as the default, i.e. *Property > Client > Attribute*. (e.g. If you set the resource property `api_version` to *200*, and set the client parameter `api_version` to *300*, it will use the module **API200**, since the resource property takes precedence over the client parameter)

## Attributes
 - `node['oneview']['ruby_sdk_version']` - Set which version of the SDK to install and use. Defaults to `'~> 4.1'`
 - `node['oneview']['save_resource_info']` - Save resource info to a node attribute? Defaults to `['uri']`. Possible values/types:
   - `true` - Save all info (Merged hash of OneView info and Chef resource properties). Warning: Resource credentials will be saved if specified.
   - `false` - Do not save any info.
   - `Array` - i.e. `['uri', 'status', 'created_at']` Save a subset of specified attributes.
 - `node['oneview']['api_version']` - When looking for a matching Chef resource provider class, this version will be used as default. Defaults to `200`.
 - `node['oneview']['api_variant']` - When looking for a matching Chef resource provider class, this variant will be used as default. Defaults to `C7000`.

### Client Property
Explicitly pass in the `client` property to each resource. This takes precedence over environment variables and allows you to set more client properties. This also allows you to get these credentials from other sources like encrypted databags, Vault, etc.

```ruby
my_client = {
  url: 'https://example.com',
  user: 'username',
  password: 'password',
  api_version: 2400
}
```

HPE Synergy Image Streamer access token is the same as the HPE OneView associated appliance, so most of its credentials you may get from the HPE OneView.

## Resources

### Resource Properties
The following are the standard properties available for all resources. Some resources have additional properties or small differences.

```ruby
oneview_ethernet_network 'Eth1' do
  client my_client
  api_version 2400
  api_variant 'Synergy'
  data(
    vlanId: 1001,
    purpose: 'General',
    smartLink: false,
    privateNetwork: false,
    bandwidth: {
      typicalBandwidth: 2000,
      maximumBandwidth: 9000
    }
  )
  action :create_if_missing
end
```

## Examples
The examples provided here will help you to understand the detailed usage of each resource in Chef Sdk. It allows users to easily create, update, query and delete resources.

You can find the resource examples [here](https://github.com/HewlettPackard/oneview-chef/blob/master/EXAMPLES.md). This document provides the list of attributes and the methods being used in each resource to perform CRUD operations on the oneview appliance.
 - attributes: client, data, scopes, etc.
 - methods: :create, :delete, :delete_bulk

## Getting Help 

Are you running into a road block? Have an issue with unexpected bahriov? Feel free to open a new issue on the [issue tracker](https://github.com/HewlettPackard/oneview-chef/issues)

For more information on how to open a new issue refer to [How can I get help & support](https://github.com/HewlettPackard/oneview-chef/wiki#getting-help---how-can-i-get-help—support)

## License
This project is licensed under the Apache 2.0 license. Please see [LICENSE](LICENSE) for more info.

## Contributing and feature requests
**Contributing:** You know the drill. Fork it, branch it, change it, commit it, and pull-request it.
We are passionate about improving this project, and glad to accept help to make it better. However, keep the following in mind:

 - You must sign a Contributor License Agreement first. Contact one of the authors (from Hewlett Packard Enterprise) for details and the CLA.
 - We reserve the right to reject changes that we feel do not fit the scope of this project, so for feature additions, please open an issue to discuss your ideas before doing the work.

**Feature Requests:** If you have a need that is not met by the current implementation, please let us know (via a new issue).
This feedback is crucial for us to deliver a useful product. Do not assume we have already thought of everything, because we assure you that is not the case.

## Testing
 - Style (Rubocop & Foodcritic): `$ rake style`
 - Unit: `$ rake unit`
 - Run all tests: `$ rake test`
 - Optional: Start guard to run tests automatically on file changes: `$ bundle exec guard`

 For more information please refer to the [Testing guidelines](TESTING.md).

## Contributors

You can find the list of contributors [here](https://github.com/HewlettPackard/oneview-chef/graphs/contributors)

## Additional Resources 

**HPE OneView Documentation**

[HPE OneView Release Notes](http://hpe.com/info/OneView/docs)

[HPE OneView Support Matrix](http://hpe.com/info/OneView/docs)

[HPE OneView Installation Guide](http://hpe.com/info/OneView/docs)

[HPE OneView User Guide](http://hpe.com/info/OneView/docs)

[HPE OneView Online Help](http://hpe.com/info/OneView/docs)

[HPE OneView REST API Reference](http://hpe.com/info/OneView/docs)

[HPE OneView Firmware Management White Paper](http://hpe.com/info/OneView/docs)

[HPE OneView Deployment and Management White Paper](http://hpe.com/info/OneView/docs)


**HPE OneView Community**

[HPE OneView Community Forums](http://hpe.com/info/oneviewcommunity)

Learn more about HPE OneView at [hpe.com/info/oneview](https://hpe.com/info/oneview)
