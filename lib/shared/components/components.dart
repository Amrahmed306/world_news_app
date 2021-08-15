import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType keyboardType,
  @required Function validatorFunction,
  Function onSubmit,
  bool isClickable = true,
  Function onChange,
  Function onTap,
  @required String labelText,
  @required IconData prefixIcon,
  bool isPassword = false,
  IconData suffixIcon,
  Function suffixPressed,
}) {
  return TextFormField(
    validator: validatorFunction,
    controller: controller,
    obscureText: isPassword,
    enabled: isClickable,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    onTap: onTap,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(),
      prefixIcon: Icon(prefixIcon),
      suffixIcon: IconButton(
        onPressed: suffixPressed,
        icon: Icon(suffixIcon),
      ),
    ),
  );
}

Widget buildArticleItem(article, context) {
  return InkWell(
    onTap: () {
      navigateTo(
        context,
        WebViewScreen(article['url']),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildArticleSeparator() {
  return Padding(
    padding: const EdgeInsetsDirectional.only(
      start: 20,
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      height: 1,
      width: double.infinity,
    ),
  );
}

Widget buildArticleBuilder(list, context, {isSearch = false}) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) {
      return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(
          list[index],
          context,
        ),
        separatorBuilder: (context, index) => buildArticleSeparator(),
        itemCount: list.length,
      );
    },
    fallback: (context) => isSearch
        ? Container()
        : Center(
            child: CircularProgressIndicator(),
          ),
  );
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}
