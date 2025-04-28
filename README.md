# Kitchen-Monitors
This is a simple python program that checks the temperature periodically (based on the crontab setting in `pyproject.toml`), and will send an email alert if it is above a certain threshold (based on the settings in 1info.csv`).

### info.csv
This is stupid simple formatting.  One row, no headers.  First column is the temperature for a cooler, second column is the temperature for a freezer, and the third column is the recipient's email address.

### Installation
If you want the code to function 'as is', clone into the repo from the home directory of the 'pi' user on a raspberry pi.

```bash
cd ~
git clone https://github.com/nitsewg/kitchen-monitors.git
```

Then cd into the kitchen-monitors directory, and run the setup script.

```bash
cd kitchen-monitors
./setup.sh
```

Once you have run the setup script, reboot the pi to make sure the environment variable is set.

```bash
sudo reboot
```

With the default settings, it will install a cron job to run the temp check every 2 hours.