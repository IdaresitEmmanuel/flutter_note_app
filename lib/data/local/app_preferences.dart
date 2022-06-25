import 'package:note_app/core/constants/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefrences {
  static const filterKey = "filter_key";
  static Future<Filter> getFilter() async {
    final pref = await SharedPreferences.getInstance();
    String filterName;
    try {
      filterName = pref.getString(filterKey) ?? Filter.none.name;
    } catch (e) {
      filterName = Filter.none.name;
    }
    return {
      Filter.alphabet.name: Filter.alphabet,
      Filter.date.name: Filter.date,
      Filter.none.name: Filter.none
    }[filterName] as Filter;
  }

  static Future<bool> setFilter(Filter filter) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(filterKey, filter.name);
  }
}
