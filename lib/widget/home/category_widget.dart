ends StatefulWidget {
  final String text;
  final String imageUrl;

  CategoryWidget(this.text, {this.imageUrl = ""});

  @override
  CategoryWidgetState createState() {
    return new CategoryWidgetState();
  }
}

class CategoryWidgetState extends State<CategoryWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76.0,
      alignment: Alignment.center,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 68.0,
            width: 68.0,
            child: Center(
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  height: 56.0,
                  width: 56.0,
                  fit: BoxFit.cover,
                  placeholder: Container(
                    height: 56.0,
                    width: 56.0,
                    color: Colors.blueGrey[100],
                  ),
                ),
              ),
            ),
          ),
          Text(
            widget.text,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
