## OBS RePlay

An OBS Studio lua script that moves newly created recordings, replays and screenshots to a folder with the same name as the current scene.

This script is a revised version of [OBSPlay](https://obsproject.com/forum/resources/obsplay-nvidia-shadowplay-alternative.1326/) by [Kwozy](https://obsproject.com/forum/members/kwozy.337414/).

Follow [MFGAVIN](https://github.com/MFGAVIN/OBS-Alternative-to-Shadowplay)'s guide on how to use OBS as an alternative to Shadowplay.

Tested only on Windows 10.

## How to use

Download the `OBSRePlay.lua` file in this repository, go to `Tools` > `Scripts`, click on the `+` sign and select the `OBSRePlay.lua` file.

By default, the output path will be the same one from your OBS output settings.

After finishing recording, taking a screenshot or saving a replay buffer, the output will be moved to the folder `<OUTPUT_PATH>\<SCENE_NAME>\<FILE_NAME>`.

## License

This project is licensed under the MIT License.
