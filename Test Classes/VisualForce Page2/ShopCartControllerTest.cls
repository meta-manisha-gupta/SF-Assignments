@IsTest
private class ShopCartControllerTest {
    public static ShoppingCartController cartControllerInstance;
    @testSetup
    static void setup(){
        List<SObject> listOfRecords = new List<SObject>();
        for(Integer i = 0; i < 5; i++) {
            Product__c newProduct = new Product__c(Name = 'Book '+i, Type__c = 'Books', Price__c = 100*(i+1), 
                                                   Product_Code__c = '12'+i, Product_Quantity__c = 5+i, 
                                                   Product_Description__c = 'Book');
            listOfRecords.add(newProduct);
        }
        for(Integer i = 0; i < 5; i++) {
            Product__c newProduct = new Product__c(Name = 'Acc '+i, Type__c = 'Accessories', Price__c = 100*(i+1), 
                                                   Product_Code__c = '15'+i, Product_Quantity__c = 2+i, 
                                                   Product_Description__c = 'Accessories');
            listOfRecords.add(newProduct);
        }
        for(Integer i = 0; i < 5; i++) {
            Contact newContact = new Contact(FirstName = 'Test '+i, LastName = 'test '+i, Subject__c = 'English');
            listOfRecords.add(newContact);
        }
        
        Purchase_Order__c purchaseOrder = new Purchase_Order__c(Name = 'Test order');
        listOfRecords.add(purchaseOrder);
        insert listOfRecords;
    }
    
    public static ShoppingCartController getCartControllerInstance() {
        ShoppingCartController controllerInstance;
        if(cartControllerInstance == null ) {
            Purchase_Order__c purchaseOrder = new Purchase_Order__c();
        	ApexPages.StandardController stdController = new ApexPages.StandardController(purchaseOrder);
            controllerInstance = new ShoppingCartController(stdController);
        }
        return controllerInstance;
    }
    @IsTest
    static void testHide() {
        cartControllerInstance = getCartControllerInstance();
        cartControllerInstance.hide();
        Boolean expected = false;
        Test.startTest();
        	Boolean actual = cartControllerInstance.isProductAvailableInCart;
        Test.stopTest();
        System.assertEquals(expected, actual);
    }
    public static Map<Id, Product__c> createMapOfIdAndProduct() {
        Map<Id, Product__c> MapOfIdAndProduct = new Map<Id, Product__c>();
        for(Product__c productInstance : [SELECT id, Name, Type__c, Price__c, Product_Code__c, Product_Quantity__c, Product_Description__c FROM Product__c order by name]){
            MapOfIdAndProduct.put(productInstance.Id, productInstance);
        }
        return MapOfIdAndProduct;
    }
    @IsTest
    static void testCreateOrder() {
        cartControllerInstance = getCartControllerInstance();
        Test.startTest();
        	cartControllerInstance.createOrder();
        Test.stopTest();
        Map<Id, Product__c> expectedProductMap = createMapOfIdAndProduct();
        Map<Id, Product__c> actualProductMap = cartControllerInstance.productMap;
        
        Map<Id, Product__c> expectedAllProductMap = createMapOfIdAndProduct();
        Map<Id, Product__c> actualAllProductMap = cartControllerInstance.productMap;
        
        Boolean expectedIsProductAvailableInStore = true;
        Boolean actualIsProductAvailableInStore = cartControllerInstance.isProductAvailableInStore;
        
        Decimal expectedTotalCost = 0;
        Decimal actualTotalCost = cartControllerInstance.totalCost;
        
        Integer expectedNumberOfProducts = 0;
        Integer actualNumberOfProducts = cartControllerInstance.numberOfProducts;
        
        system.assertEquals(expectedProductMap, actualProductMap);
        system.assertEquals(expectedAllProductMap, actualAllProductMap);
        system.assertEquals(expectedIsProductAvailableInStore, actualIsProductAvailableInStore);
        system.assertEquals(expectedTotalCost, actualTotalCost);
        system.assertEquals(expectedNumberOfProducts, actualNumberOfProducts);
    }
    
    public static Map<Id,PurchaseOrderLineItem__c> createCartMap(Id productId) {
        Map<Id,PurchaseOrderLineItem__c> cartMap = new Map<Id,PurchaseOrderLineItem__c>();
        if(createMapOfIdAndProduct().containsKey(productId)){
            Purchase_Order__c order = new Purchase_Order__c();
            PurchaseOrderLineItem__c productInCart = new PurchaseOrderLineItem__c(
                PurchaseOrder__c = order.Id, 
                Product__r = createMapOfIdAndProduct().get(productId),
                Quantity__c = 1,
                Total_Price__c = createMapOfIdAndProduct().get(productId).Price__c
            );
            cartMap.put(productId, productInCart);
        }
        return cartMap;
    }
    public static Product__c getProduct(){
        Product__c product = [SELECT id, Name, Type__c, Price__c, Product_Code__c, Product_Quantity__c,
                              Product_Description__c FROM Product__c Where Name = 'Book 1'];
        return product;
    }
    @IsTest
    static void testAddProductToCart() {
        cartControllerInstance = getCartControllerInstance();
        Product__c product = getProduct();
        cartControllerInstance.flag = false;
        cartControllerInstance.productMap = createMapOfIdAndProduct();
        cartControllerInstance.productId = product.Id;
        cartControllerInstance.order = new Purchase_Order__c();
        cartControllerInstance.totalCost = 0;
        
        Test.startTest();
            cartControllerInstance.addProductToCart();
        Test.stopTest();
        
        Map<Id,PurchaseOrderLineItem__c> expectedCartMap = createCartMap(product.Id);
        Map<Id,PurchaseOrderLineItem__c> actualCartMap = cartControllerInstance.cartMap;
        
        Integer expectedNumberOfProducts = expectedCartMap.size();
        Integer actualNumberOfProducts = cartControllerInstance.numberOfProducts;
        
        System.assertEquals(cartControllerInstance.productMap.containsKey(product.Id), false);
        System.assertEquals(expectedCartMap, actualCartMap);
        System.assertEquals(expectedNumberOfProducts, actualNumberOfProducts);
        System.assertEquals(cartControllerInstance.productMap.containsKey(product.Id), false);
        System.assertEquals(cartControllerInstance.isProductAvailableInCart, true);
    }
    @IsTest
    static void testDeleteProductFromCart() {
        cartControllerInstance = getCartControllerInstance();
        Product__c product = getProduct();
        cartControllerInstance.productMap = createMapOfIdAndProduct();
        cartControllerInstance.cartProductId = product.Id;
        cartControllerInstance.cartMap = createCartMap(product.Id);
        cartControllerInstance.totalCost = 200;
        
        Test.startTest();
        	cartControllerInstance.deleteProductFromCart();
        Test.stopTest();
        
        System.assertEquals(cartControllerInstance.isProductListEmpty, false);
        System.assertEquals(cartControllerInstance.productMap.containsKey(product.Id), true);
        System.assertEquals(cartControllerInstance.cartMap.containsKey(product.Id), false);
    }
    @IsTest 
    static void testChangeEditModeshouldSaveCartProductId() {
        cartControllerInstance = getCartControllerInstance();
        Product__c product = getProduct();
        cartControllerInstance.CartproductId = product.Id;
        cartControllerInstance.isEditable = false;
        Test.startTest();
        	cartControllerInstance.changeEditMode();
        Test.stopTest();
        System.assertEquals(true, cartControllerInstance.isEditable);
        System.assertEquals(cartControllerInstance.CartproductId, cartControllerInstance.previousCartProductId);
    }
    
    @IsTest 
    static void testUpdateProductInCartShouldUpdate() {
        cartControllerInstance = getCartControllerInstance();
        Product__c product = getProduct();
        cartControllerInstance.productId = product.Id;
        cartControllerInstance.allProductMap = createMapOfIdAndProduct();
        cartControllerInstance.CartproductId = product.Id;
        cartControllerInstance.cartMap = createCartMap(product.Id);
        cartControllerInstance.cartMap.get(product.Id).Quantity__c = 3;
        cartControllerInstance.totalCost = 200;
        Test.startTest();
        	cartControllerInstance.updateProductInCart();
        Test.stopTest();

        system.assertEquals(600,cartControllerInstance.totalCost);
        System.assertNotEquals(1, cartControllerInstance.cartMap.get(product.Id).Quantity__c);
        System.assertEquals(false, cartControllerInstance.isEditable);
    }
    @IsTest 
    static void testUpdateProductInCartShouldShowError() {
        cartControllerInstance = getCartControllerInstance();
        Product__c product = getProduct();
        cartControllerInstance.CartproductId = product.Id;
        cartControllerInstance.cartMap = createCartMap(product.Id);
        cartControllerInstance.cartMap.get(product.Id).Quantity__c = 3.5;
        cartControllerInstance.totalCost = 200;
        
        Test.startTest();
        	cartControllerInstance.updateProductInCart();
        Test.stopTest();
        ApexPages.Message[] pageMessages = ApexPages.getMessages();
        
        String actualPageMessage;
        String expectedPageMessage = 'Quantity "3.5" is not valid';
        for(ApexPages.Message pageMessage : pageMessages) {
            actualPageMessage = pageMessage.getSummary();
        }
        
        System.assertNotEquals(0, pageMessages.size());
        system.assertEquals(expectedPageMessage, actualPageMessage);
        system.assertEquals(200,cartControllerInstance.totalCost);
        System.assertNotEquals(3.5, cartControllerInstance.cartMap.get(product.Id).Quantity__c);
        System.assertEquals(false, cartControllerInstance.isEditable);
    }
    @IsTest 
    static void testUpdateProductInCartShouldNotUpdate() {
        cartControllerInstance = getCartControllerInstance();
        Product__c product = getProduct();
        cartControllerInstance.CartproductId = product.Id;
        cartControllerInstance.cartMap = createCartMap(product.Id);
        cartControllerInstance.allProductMap = createMapOfIdAndProduct();
        cartControllerInstance.cartMap.get(product.Id).Quantity__c = 8;
        cartControllerInstance.totalCost = 200;
        
        Test.startTest();
        	cartControllerInstance.updateProductInCart();
        Test.stopTest();
        
        ApexPages.Message[] pageMessages = ApexPages.getMessages();
        String actualPageMessage;
        String expectedPageMessage = 'Quantity has exceeded, available quantity is 6';
        for(ApexPages.Message pageMessage : pageMessages) {
            actualPageMessage = pageMessage.getSummary();
        }
        
        System.assertNotEquals(0, pageMessages.size());
        system.assertEquals(expectedPageMessage, actualPageMessage);
        system.assertEquals(200,cartControllerInstance.totalCost);
        System.assertNotEquals(3.5, cartControllerInstance.cartMap.get(product.Id).Quantity__c);
        System.assertEquals(false, cartControllerInstance.isEditable);
    }
    @IsTest 
    static void testCheckQuantityShouldReturnTrue() {
        cartControllerInstance = getCartControllerInstance();
        Product__c product = getProduct();
        cartControllerInstance.CartproductId = product.Id;
        cartControllerInstance.allProductMap = createMapOfIdAndProduct();
        
        Test.startTest();
        	Boolean actual = cartControllerInstance.checkQuantity(4);
        Test.stopTest();
        
        System.assertEquals(true, actual);
    }
    @IsTest 
    static void testCheckQuantityShouldReturnFalse() {
        cartControllerInstance = getCartControllerInstance();
        Product__c product = getProduct();
        cartControllerInstance.CartproductId = product.Id;
        cartControllerInstance.allProductMap = createMapOfIdAndProduct();
        
        Test.startTest();
        	Boolean actual = cartControllerInstance.checkQuantity(8);
        Test.stopTest();
        
        System.assertEquals(false, actual);
    }
    @IsTest
    static void testResetQuantity() {
        cartControllerInstance = getCartControllerInstance();
        Product__c product = getProduct();
        cartControllerInstance.CartproductId = product.Id;
        cartControllerInstance.cartMap = createCartMap(product.Id);
        cartControllerInstance.totalCost = 200;
        
        Test.startTest();
        	cartControllerInstance.resetQuantity();
        Test.stopTest();
        
        System.assertEquals(1, cartControllerInstance.cartMap.get(product.Id).Quantity__c);
        System.assertEquals(200, cartControllerInstance.totalCost);
    }
    @IsTest
    static void testGetProductsInCart() {
        cartControllerInstance = getCartControllerInstance();
        Product__c product = getProduct();
        cartControllerInstance.cartMap = createCartMap(product.Id);
        List<PurchaseOrderLineItem__c> expectedProductsInCart = createCartMap(product.Id).values();
        
        Test.startTest();
        	List<PurchaseOrderLineItem__c> actualProductsInCart = cartControllerInstance.getProductsInCart();
        Test.stopTest();
        
        System.assertEquals(actualProductsInCart, expectedProductsInCart);
    }
    @IsTest
    static void testCheckoutShouldInsertOrder() {
        cartControllerInstance = getCartControllerInstance();
        Product__c product = getProduct();
        Purchase_Order__c order = new Purchase_Order__c();
        cartControllerInstance.order = order;
        cartControllerInstance.CartproductId = product.Id;
        cartControllerInstance.cartMap = createCartMap(product.Id);
        
        Test.startTest();
        	cartControllerInstance.checkout();
        Test.stopTest();
        
        System.assertEquals(order.id,cartControllerInstance.order.Id);
        PurchaseOrderLineItem__c expected = cartControllerInstance.cartMap.values();
        PurchaseOrderLineItem__c actualOrder = [SELECT PurchaseOrder__c, Quantity__c, Total_Price__c, Product__c, id FROM PurchaseOrderLineItem__c];
        system.debug('ac '+actualOrder);
        system.debug('ex '+expected);
        system.assertEquals(true, cartControllerInstance.cartMap.containsKey(product.Id));
        
        
    }
    @IsTest
    static void testCancel() {
        cartControllerInstance = getCartControllerInstance();
        string expectedHomePage = Page.PurchaseOrdersHomePage.getUrl();
        
        Test.startTest();
        	string actualHomePage = cartControllerInstance.cancel().getUrl();
        Test.stopTest();
        
        system.assertEquals(expectedHomePage, actualHomePage);
    }
    @IsTest
    static void testRedirectToHome() {
        cartControllerInstance = getCartControllerInstance();
        string expectedHomePage = Page.PurchaseOrdersHomePage.getUrl();
        
        Test.startTest();
        	string actualHomePage = cartControllerInstance.redirectToHome().getUrl();
        Test.stopTest();
        
        system.assertEquals(expectedHomePage, actualHomePage);
    }
    @IsTest
    static void testGetAllProducts() {
        cartControllerInstance = getCartControllerInstance();
        cartControllerInstance.productMap = createMapOfIdAndProduct();
        List<Product__c> expectedListOfProducts = createMapOfIdAndProduct().values();
        
        Test.startTest();
        	List<Product__c> actualListOfProducts = cartControllerInstance.getAllProducts();
        Test.stopTest();
        
        system.assertEquals(expectedListOfProducts, actualListOfProducts);
    }
    @IsTest
    static void testValidateQuantityShouldReturnTrue(){
        cartControllerInstance = getCartControllerInstance();
       	Boolean expected = true;
        Test.startTest();
        	Boolean actual = cartControllerInstance.validateQuantity(5);
        Test.stopTest();
        system.assertEquals(expected, actual);
    }
    @IsTest
    static void testValidateQuantityShouldReturnFalse(){
        cartControllerInstance = getCartControllerInstance();
       	Boolean expected = false;
        Test.startTest();
        	Boolean actual = cartControllerInstance.validateQuantity(5.9);
        Test.stopTest();
        system.assertEquals(expected, actual);
    }
}