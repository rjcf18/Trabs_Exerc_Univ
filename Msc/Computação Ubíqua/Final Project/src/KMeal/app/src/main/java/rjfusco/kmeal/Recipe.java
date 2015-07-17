package rjfusco.kmeal;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by ricardo on 12-07-2015.
 */
public class Recipe implements Serializable{
    private String name, dishType, description, prepareMode;
    private int rating;
    private String ingredients;

    public Recipe(String name, String dishType, String description, String prepareMode,
                  int rating, String ingredients) {
        this.name = name;
        this.dishType = dishType;
        this.description = description;
        this.prepareMode = prepareMode;
        this.rating = rating;
        this.ingredients = ingredients;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDishType() {
        return dishType;
    }

    public void setDishType(String dishType) {
        this.dishType = dishType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPrepareMode() {
        return prepareMode;
    }

    public void setPrepareMode(String prepareMode) {
        this.prepareMode = prepareMode;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getIngredients() {
        return ingredients;
    }

    public void setIngredients(String ingredients) {
        this.ingredients = ingredients;
    }
}
