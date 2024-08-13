/// Тип метода оплаты - онлайн в приложении или курьеру при получении.
enum PaymentMethodType { online, courier }

/// Варианты оплаты онлайн - картой, через СБП или СберПей.
enum OnlinePaymentMethod { bankCard, sbp, sberPay }

/// Варианты оплаты курьеру - наличными или через терминал.
enum CourierPaymentMethod { cash, terminal }
