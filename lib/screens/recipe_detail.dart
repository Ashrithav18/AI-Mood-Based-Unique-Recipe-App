
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:food/screens/wishlist_page.dart';

// Make sure this is defined (either here or in wishlist_dart.dart)
List<Map<String, dynamic>> wishlist = [];

class RecipeDetailPage extends StatefulWidget {
  final Map<String, dynamic> food;
  const RecipeDetailPage({Key? key, required this.food}) : super(key: key);

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  bool isInWishlisted = false;
  int _rating = 0;
  double avgRating = 0;
  int ratingCount = 0;

  // Video controllers
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isVideoInitialized = false;
  bool _hasVideoError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    isInWishlisted = wishlist.any((item) => item['name'] == widget.food['name']);
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    final videoUrl = widget.food['video'];

    if (videoUrl == null || videoUrl.isEmpty) {
      setState(() {
        _hasVideoError = true;
        _errorMessage = 'No video URL provided';
      });
      return;
    }

    try {
      _videoPlayerController = VideoPlayerController.asset(videoUrl);
      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.orange,
          handleColor: Colors.orange,
          backgroundColor: Colors.grey[300]!,
          bufferedColor: Colors.grey[200]!,
        ),
        errorBuilder: (context, errorMessage) {
          return _buildVideoError(errorMessage);
        },
      );

      setState(() {
        _isVideoInitialized = true;
        _hasVideoError = false;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _isVideoInitialized = false;
        _hasVideoError = true;
        _errorMessage = e.toString();
      });
    }
  }

  Widget _buildVideoError(String errorMessage) {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 50, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              'Video unavailable',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoLoading() {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
            SizedBox(height: 16),
            Text(
              "Loading video...",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.orange[700],
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        content,
        style: TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }

  // UPDATED: Container + Row approach for long text
  Widget _buildInfoChip(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(20),
      ),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 32, // full width minus padding
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.orange),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label: $value',
              style: TextStyle(fontWeight: FontWeight.w500),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  dynamic _getField(String baseName) {
    if (widget.food.containsKey(baseName)) {
      return widget.food[baseName];
    }
    final emojiVariants = ['🧑‍🍳', '🔥', '🌿', '🍛'];
    for (var emoji in emojiVariants) {
      final key = '$baseName$emoji';
      if (widget.food.containsKey(key)) {
        return widget.food[key];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = _getField('ingredients');
    final String ingredientsText;
    if (ingredients is List) {
      ingredientsText = ingredients.join(', ');
    } else if (ingredients is String) {
      ingredientsText = ingredients;
    } else {
      ingredientsText = 'No ingredients listed';
    }

    final recipe = _getField('recipe') ?? 'No recipe available';
    final calories = _getField('calories') ?? 'N/A';
    final benefits = _getField('benefits') ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.food['name'] ?? 'Recipe Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isInWishlisted ? Icons.favorite : Icons.favorite_border,
              color: isInWishlisted ? Colors.red : Colors.white,
              size: 28,
            ),
            onPressed: () {
              setState(() {
                if (isInWishlisted) {
                  wishlist.removeWhere(
                      (item) => item['name'] == widget.food['name']);
                } else {
                  wishlist.add(widget.food);
                }
                isInWishlisted = !isInWishlisted;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isInWishlisted
                          ? 'Added to wishlist!'
                          : 'Removed from wishlist',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.orange,
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video section
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _isVideoInitialized && _chewieController != null
                    ? Chewie(controller: _chewieController!)
                    : _hasVideoError
                        ? _buildVideoError(_errorMessage)
                        : _buildVideoLoading(),
              ),
            ),

            SizedBox(height: 24),

            // Rating section
            Center(
              child: Column(
                children: [
                  Text(
                    "Rate this recipe",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (i) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _rating = i + 1;
                            ratingCount++;
                            avgRating = ((avgRating * (ratingCount - 1)) + _rating) / ratingCount;
                          });
                        },
                        child: Icon(
                          i < _rating ? Icons.star : Icons.star_border,
                          color: Colors.orange,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    ratingCount == 0 ? "No ratings yet" : "Your Rating: $_rating/5",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Average: ${avgRating.toStringAsFixed(1)}/5 (${ratingCount} ratings)",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Info chips (now fully supports long text)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (calories != 'N/A')
                  _buildInfoChip('Calories', calories, Icons.local_fire_department),
                if (benefits.isNotEmpty)
                  _buildInfoChip('Benefits', benefits, Icons.health_and_safety),
              ],
            ),

            SizedBox(height: 24),

            // Ingredients section
            _buildSectionTitle("Ingredients"),
            _buildSectionContent(ingredientsText),

            // Recipe section
            _buildSectionTitle("Recipe Instructions"),
            _buildSectionContent(recipe),
          ],
        ),
      ),
    );
  }
}


