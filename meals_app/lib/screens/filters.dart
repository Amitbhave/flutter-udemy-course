import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealsapp/widgets/drawer.dart';

class Filters extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  Filters(this.saveFilters, this.currentFilters);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    super.initState();
    _glutenFree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
  }

  Widget _buildSwitchTileList(String title, String description, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final filters = {
                'gluten': _glutenFree,
                'vegetarian': _vegetarian,
                'vegan': _vegan,
                'lactose': _lactoseFree,
              };
              widget.saveFilters(filters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchTileList('Gluten-free', 'Only include gluten-free meals.', _glutenFree, (newValue){
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                _buildSwitchTileList('Vegetarian', 'Only include vegetarian meals.', _vegetarian, (newValue){
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                _buildSwitchTileList('Vegan', 'Only include vegan meals.', _vegan, (newValue){
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                _buildSwitchTileList('Lactose-free', 'Only include lactose-free meals.', _lactoseFree, (newValue){
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}