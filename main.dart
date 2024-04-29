import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// Model class for songs
class Song {
  final String thumbnail;
  final String audioLink;
  final String audioTitle;
  final String genre;

  Song({
    required this.thumbnail,
    required this.audioLink,
    required this.audioTitle,
    required this.genre,
  });
}

class User {
  String username;
  String phoneNumber;
  List<Song> playlist;

  User({
    required this.username,
    required this.phoneNumber,
    required this.playlist,
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musify',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: MyHomePage(
        toggleTheme: () {
          setState(() {
            _isDarkMode = !_isDarkMode;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final VoidCallback toggleTheme;

  MyHomePage({required this.toggleTheme});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AudioPlayer _audioPlayer;

  late User user;
  final List<Song> songs = [
    Song(
      thumbnail:
          'https://cdn.pixabay.com/audio/2022/10/24/13-25-03-785_200x200.jpg',
      audioLink:
          'https://cdn.pixabay.com/audio/2023/11/18/audio_178dcdfe7b.mp3',
      audioTitle: 'Alice in Dark Wonderland',
      genre: 'Electronic',
    ),
    Song(
      thumbnail:
          'https://cdn.pixabay.com/audio/2022/05/17/20-43-50-193_200x200.jpg',
      audioLink:
          'https://cdn.pixabay.com/audio/2022/10/24/audio_b2facfbc5e.mp3',
      audioTitle: 'Metal (Dark Matter)',
      genre: 'Metal',
    ),
    Song(
      thumbnail:
          'https://cdn.pixabay.com/audio/2022/11/21/17-24-14-792_200x200.jpg',
      audioLink:
          'https://cdn.pixabay.com/audio/2022/11/21/audio_aef466503e.mp3',
      audioTitle: 'Crazy chase',
      genre: 'Rock',
    ),
    Song(
      thumbnail:
          'https://cdn.pixabay.com/audio/2023/11/04/10-41-47-62_200x200.jpg',
      audioLink:
          'https://cdn.pixabay.com/audio/2023/11/04/audio_9e0041a577.mp3',
      audioTitle: 'Bounce Gone Crazy Instrumental',
      genre: 'Electronic',
    ),
    Song(
      thumbnail:
          'https://cdn.pixabay.com/audio/2023/12/08/16-45-20-685_200x200.jpg',
      audioLink:
          'https://cdn.pixabay.com/audio/2023/12/08/audio_b3eae6304f.mp3',
      audioTitle: 'Crazy Swing Shuffle Session',
      genre: 'Jazz',
    ),
    // Add more songs here...
    Song(
      thumbnail:
          'https://cdn.pixabay.com/audio/2022/09/30/10-46-32-772_200x200.jpg',
      audioLink:
          'https://cdn.pixabay.com/audio/2022/09/30/audio_3d5d71149b.mp3',
      audioTitle: 'Happy ghost',
      genre: 'Pop',
    ),
    Song(
      thumbnail:
          'https://cdn.pixabay.com/audio/2024/04/14/10-41-09-922_200x200.png',
      audioLink:
          'https://cdn.pixabay.com/audio/2024/04/14/audio_9e9077bc56.mp3',
      audioTitle: 'Party madness',
      genre: 'Dance',
    ),
    Song(
      thumbnail:
          'https://cdn.pixabay.com/audio/2024/04/07/14-32-16-517_200x200.jpg',
      audioLink:
          'https://cdn.pixabay.com/audio/2023/11/18/audio_8ed8d9e40a.mp3',
      audioTitle: 'Technology Innovations',
      genre: 'Electronic',
    ),
    Song(
      thumbnail:
          'https://cdn.pixabay.com/audio/2023/11/18/11-58-20-560_200x200.jpg',
      audioLink:
          'https://cdn.pixabay.com/audio/2022/04/27/audio_fbb7ac29bf.mp3',
      audioTitle: 'A Quirky Moment',
      genre: 'Experimental',
    ),
    Song(
      thumbnail:
          'https://cdn.pixabay.com/audio/2022/04/27/05-06-25-14_200x200.png',
      audioLink:
          'https://cdn.pixabay.com/audio/2023/10/17/audio_5e5a5401b0.mp3',
      audioTitle: 'Running on waves',
      genre: 'Pop',
    ),
    Song(
      thumbnail:
          'https://cdn.pixabay.com/audio/2023/11/18/11-54-24-77_200x200.jpg',
      audioLink:
          'https://cdn.pixabay.com/audio/2024/04/14/audio_f63abdc99e.mp3',
      audioTitle: 'Going wacky',
      genre: 'Comedy',
    ),
  ];

  List<Song> filteredSongs = [];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    user = User(
      username: 'Jone Doe',
      phoneNumber: '1234567890',
      playlist: [],
    );
    filteredSongs = List.from(songs);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Callback function to remove a song from the playlist
  void removeSongFromPlaylist(int index) {
    setState(() {
      user.playlist.removeAt(index);
    });
  }

  // Function to navigate to the user details editing page
  void navigateToUserDetailsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailsPage(
          user: user,
          updateUserDetails: (User updatedUser) {
            setState(() {
              user = updatedUser;
            });
          },
        ),
      ),
    );
  }

  // Function to filter songs based on search query
  void filterSongs(String query) {
    setState(() {
      if (query.isNotEmpty) {
        final String lowerCaseQuery = query.toLowerCase();
        filteredSongs = songs.where((song) {
          return song.audioTitle.toLowerCase().contains(lowerCaseQuery);
        }).toList();
      } else {
        filteredSongs = List.from(songs);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Musify',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Songs',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: filterSongs,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSongs.length,
              itemBuilder: (context, index) {
                return SongListItem(
                  song: filteredSongs[index],
                  onAddToPlaylist: () {
                    if (!user.playlist.contains(filteredSongs[index])) {
                      setState(() {
                        user.playlist.add(filteredSongs[index]);
                      });
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.library_music),
                onPressed: () {
                  // Show all songs
                },
              ),
              IconButton(
                icon: Icon(Icons.playlist_play),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaylistPage(
                        user: user,
                        removeSongFromPlaylist: removeSongFromPlaylist,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed:
                    navigateToUserDetailsPage, // Navigate to user details page
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.toggleTheme,
        child: Icon(Icons.brightness_4),
      ),
    );
  }
}

class PlaylistPage extends StatelessWidget {
  final User user;
  final Function(int) removeSongFromPlaylist; // Callback function

  PlaylistPage({
    required this.user,
    required this.removeSongFromPlaylist,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist'),
      ),
      body: ListView.builder(
        itemCount: user.playlist.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(user.playlist[index].thumbnail),
            title: Text(user.playlist[index].audioTitle),
            subtitle: Text(user.playlist[index].genre),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Call the callback function to remove the song
                    removeSongFromPlaylist(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    // Play the song
                  },
                ),
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () {
                    // Pause the song
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class UserDetailsPage extends StatefulWidget {
  final User user;
  final Function(User) updateUserDetails;

  UserDetailsPage({required this.user, required this.updateUserDetails});

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late TextEditingController _usernameController;
  late TextEditingController _phoneNumberController;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _phoneNumberController =
        TextEditingController(text: widget.user.phoneNumber);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Dark Theme'),
                Switch(
                  value: _isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      _isDarkMode = value;
                    });
                    // Update the theme based on the checkbox state
                    widget.updateUserDetails(widget.user);
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final updatedUser = User(
                  username: _usernameController.text,
                  phoneNumber: _phoneNumberController.text,
                  playlist: widget.user.playlist,
                );
                widget.updateUserDetails(updatedUser);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class SongListItem extends StatefulWidget {
  final Song song;
  final VoidCallback onAddToPlaylist;

  SongListItem({required this.song, required this.onAddToPlaylist});

  @override
  _SongListItemState createState() => _SongListItemState();
}

class _SongListItemState extends State<SongListItem> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _volume = 1.0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _audioPlayer.onAudioPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Function to adjust the volume
  void setVolume(double volume) {
    _audioPlayer.setVolume(volume);
    setState(() {
      _volume = volume;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.song.thumbnail),
      title: Text(widget.song.audioTitle),
      subtitle: Text(widget.song.genre),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: widget.onAddToPlaylist,
          ),
          IconButton(
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              if (_isPlaying) {
                _audioPlayer.pause();
              } else {
                _audioPlayer.play(widget.song.audioLink, position: _position);
              }
              setState(() {
                _isPlaying = !_isPlaying;
              });
            },
          ),
        ],
      ),
      // Add a small progress indicator below the song item
      // to display the song progress
      dense: true,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Song Progress'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LinearProgressIndicator(
                    value: _duration.inMilliseconds > 0
                        ? _position.inMilliseconds.toDouble() /
                            _duration.inMilliseconds.toDouble()
                        : 0.0,
                  ),
                  SizedBox(height: 16),
                  StreamBuilder(
                    stream: _audioPlayer.onAudioPositionChanged,
                    builder: (context, snapshot) {
                      return Text(
                        '${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')} / ${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.volume_down),
                        onPressed: () {
                          // Decrease volume
                          if (_volume > 0) {
                            setVolume(_volume - 0.1);
                          }
                        },
                      ),
                      SizedBox(
                        width: 100, // Adjust width as needed
                        child: Slider(
                          value: _volume,
                          min: 0,
                          max: 1,
                          onChanged: (value) {
                            setVolume(value);
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.volume_up),
                        onPressed: () {
                          // Increase volume
                          if (_volume < 1) {
                            setVolume(_volume + 0.1);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
