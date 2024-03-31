SELECT        Production.ProductSubcategory.ProductSubcategoryID, Production.ProductCategory.ProductCategoryID, Production.ProductCategory.Name AS [Category Name], 
                         Production.ProductSubcategory.Name AS [Subcategory Name]
FROM            Production.ProductCategory INNER JOIN
                         Production.ProductSubcategory ON Production.ProductCategory.ProductCategoryID = Production.ProductSubcategory.ProductCategoryID