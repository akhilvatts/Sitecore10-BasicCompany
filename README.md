# Sitecore10-BasicCompany
This is a fork repo from Sitecore/Helix.Examples for testing of Sitecore10 codebase. 
This example contains TDS, hence you'll need TDS License before you decide to build upon this. 
To visit the actual repo, please visit [Sitecore/Helix.Examples](https://github.com/Sitecore/Helix.Examples/tree/master/examples/helix-basic-tds-consolidated)

## Running the Example

### Prerequisites

Ensure you have followed the steps listed on the [installation documentation](https://sitecore.github.io/Helix.Examples/install.html).

The Helix examples assume you have some experience with (or at least an understanding of) Docker container-based Sitecore development. For more information, see the [Sitecore Containers Documentation](https://containers.doc.sitecore.com).

#### Sitecore TDS

This example requires you to [install Sitecore TDS v6.0.0.14](https://www.teamdevelopmentforsitecore.com/Download/TDS-Classic) or higher. If you do not have a license, you can [obtain a trial license](https://www.teamdevelopmentforsitecore.com/TDS-Classic/Free-Trial).

### Set TDS license environment variables

Docker solution builds with Sitecore TDS require TDS license environment variables, as described here: https://hedgehogdevelopment.github.io/tds/chapter5.html#sitecore-tds-builds-using-cloud-servers

You'll need to set these in order to successfully build the solution in Docker. Add the following system environment variables with your TDS license details:

* `TDS_OWNER`
* `TDS_KEY`

> Alternatively, you could set these in the Docker Compose environment (.env) file. For more information about how Sitecore TDS is used with containers, see the [Sitecore Containers Documentation](https://containers.doc.sitecore.com/docs/item-deployment#sitecore-tds).

### Initialize

Open a PowerShell administrator prompt and run the following command, replacing the `-LicenseXmlPath` with the location of your Sitecore license file.

```
.\init.ps1 -LicenseXmlPath C:\License\license.xml
```

You can also set the Sitecore admin password using the `-SitecoreAdminPassword` parameter (default is "b").

This will perform any necessary preparation steps, such as populating the Docker Compose environment (.env) file, configuring certificates, and adding hosts file entries.

### Build the solution and start Sitecore

Run the following command in PowerShell.

```
docker-compose up -d
```

This will download any required Docker images, build the solution and Sitecore runtime images, and then start the containers.

Once complete, you can access the instance with the following.

* Sitecore Content Management: https://cm.basic-company-tds-consolidated.localhost
* Sitecore Identity Server: https://id.basic-company-tds-consolidated.localhost
* Basic Company site: https://www.basic-company-tds-consolidated.localhost

### Publish

The serialized items will automatically sync when the instance is started, but you'll need to publish them.

Login to Sitecore at https://cm.basic-company-tds-consolidated.localhost/sitecore and perform a site smart publish. Use "admin" and the password you specified on init ("b" by default).

You should now be able to view the Basic Company site at https://www.basic-company-tds-consolidated.localhost.

### Stop Sitecore

When you're done, stop and remove the containers using the following command.

```
docker-compose down
```

### Known Issues

There site is available for preview in Content Editor. Site definition will need to be updated according to your needs.
