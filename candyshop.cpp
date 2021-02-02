#include <stdio.h>
#include <string.h>
#include <iostream>
using namespace std;
int main()
{
    int p, w, a, b, tot;

    printf("Welcome to Bobcat Candy, home to the famous Bobcat Bars!\n ");

    printf("Please enter the price of a Bobcat Bar:");
    cin >> p;
    printf("Please enter the number of wrappers needed to exchange for a new bar:");
    cin >> w;
    printf("Please enter the amount:");
    cin >> a;

    cout << "Good! Let me run the number... " << endl;

    b = a / p;
    cout << "You first buy " << b << "bars. "<< endl;
    tot = b;

    while (b >= w)
    {

        cout << "Then, you will get another " << b / w << "bars" << endl;
        b = b / w;
        tot = tot + b;
    }
    cout << "With " << a << " bars, you will recieve a maximum of " << tot << " Bobcat bars!" << endl;
    return 0;
}