#ifndef GREEN_CONTROLLER_H
#define GREEN_CONTROLLER_H

#include <QDebug>
#include <QObject>

#include "../ga.h"

class Wallet;
class Account;

class Controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Wallet* wallet READ wallet WRITE setWallet NOTIFY walletChanged)

public:
    explicit Controller(QObject* parent = nullptr);

    Wallet* wallet() const;
    void setWallet(Wallet* wallet);

    void process(GA_json** output);

public slots:
    virtual void reset();

    void requestCode(const QByteArray& method);
    void resolveCode(const QByteArray& code);

signals:
    void walletChanged(Wallet* wallet);
    void statusChanged(const QString& status);

    void enterDone(const QJsonObject& result);
    void codeRequested(const QJsonObject& result);
    void enterResolveCode();

protected:
    Wallet* m_wallet{nullptr};
    GA_auth_handler* m_auth_handler{nullptr};
};

#endif // GREEN_CONTROLLER_H