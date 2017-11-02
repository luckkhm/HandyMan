//
//  CountryPicker.m
//
//  Version 1.2.3
//
//  Created by Nick Lockwood on 25/04/2011.
//  Copyright 2011 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/CountryPicker
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  The source code and data files in this project are the sole creation of
//  Charcoal Design and are free for use subject to the terms below. The flag
//  icons were sourced from https://github.com/koppi/iso-country-flags-svg-collection
//  and are available under a Public Domain license
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import "CountryPicker.h"


#pragma GCC diagnostic ignored "-Wselector"
#pragma GCC diagnostic ignored "-Wgnu"


#import <Availability.h>
#if !__has_feature(objc_arc)
#error This class requires automatic reference counting
#endif


@interface CountryPicker () <UIPickerViewDelegate, UIPickerViewDataSource>

@end


@implementation CountryPicker

//doesn't use _ prefix to avoid name clash with superclass
@synthesize delegate;

+ (NSArray *)countryNames
{
    static NSArray *_countryNames = nil;
    if (!_countryNames)
    {
        _countryNames = [[[[self countryNamesByCode] allValues] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] copy];
    }
    return _countryNames;
}

+ (NSArray *)countryCodes
{
    static NSArray *_countryCodes = nil;
    if (!_countryCodes)
    {
        _countryCodes = [[[self countryCodesByName] objectsForKeys:[self countryNames] notFoundMarker:@""] copy];
    }
    return _countryCodes;
}

+ (NSArray *)countryPhones
{
    static NSArray *_countryPhones = nil;
    if (!_countryPhones)
    {
        _countryPhones = [[[self countryPhonesByCode] objectsForKeys:[self countryNames] notFoundMarker:@""] copy];
    }
    return _countryPhones;
}


+ (NSDictionary *)countryPhonesByCode
{

    NSDictionary *_countryPhonesByCnode = @{
                                            @"Canada"                                       : @"+1",
                                            @"China"                                        : @"+86",
                                            @"France"                                       : @"+33",
                                            @"Germany"                                      : @"+49",
                                            @"India"                                        : @"+91",
                                            @"Japan"                                        : @"+81",
                                            @"Pakistan"                                     : @"+92",
                                            @"United Kingdom"                               : @"+44",
                                            @"United States"                                : @"+1",
                                            @"Abkhazia"                                     : @"+7 840",
                                            @"Abkhazia"                                     : @"+7 940",
                                            @"Afghanistan"                                  : @"+93",
                                            @"Albania"                                      : @"+355",
                                            @"Åland Islands"                                : @"+358",
                                            @"Algeria"                                      : @"+213",
                                            @"American Samoa"                               : @"+1 684",
                                            @"Andorra"                                      : @"+376",
                                            @"Angola"                                       : @"+244",
                                            @"Antarctica"                                   : @"+672",
                                            @"Anguilla"                                     : @"+1 264",
                                            @"Antigua and Barbuda"                          : @"+1 268",
                                            @"Argentina"                                    : @"+54",
                                            @"Armenia"                                      : @"+374",
                                            @"Aruba"                                        : @"+297",
                                            @"Ascension"                                    : @"+247",
                                            @"Australia"                                    : @"+61",
                                            @"Australian External Territories"              : @"+672",
                                            @"Austria"                                      : @"+43",
                                            @"Azerbaijan"                                   : @"+994",
                                            @"Bahamas"                                      : @"+1 242",
                                            @"Bahrain"                                      : @"+973",
                                            @"Bangladesh"                                   : @"+880",
                                            @"Barbados"                                     : @"+1 246",
                                            @"Barbuda"                                      : @"+1 268",
                                            @"Belarus"                                      : @"+375",
                                            @"Belgium"                                      : @"+32",
                                            @"Belize"                                       : @"+501",
                                            @"Benin"                                        : @"+229",
                                            @"Bermuda"                                      : @"+1 441",
                                            @"Bhutan"                                       : @"+975",
                                            @"Bolivia"                                      : @"+591",
                                            @"Bosnia and Herzegovina"                       : @"+387",
                                            @"Botswana"                                     : @"+267",
                                            @"Bouvet Island"                                : @"+55",
                                            @"Brazil"                                       : @"+55",
                                            @"British Indian Ocean Territory"               : @"+246",
                                            @"British Virgin Islands"                       : @"+1 284",
                                            @"Brunei"                                       : @"+673",
                                            @"Bulgaria"                                     : @"+359",
                                            @"Burkina Faso"                                 : @"+226",
                                            @"Burundi"                                      : @"+257",
                                            @"Cambodia"                                     : @"+855",
                                            @"Cameroon"                                     : @"+237",
                                            @"Canada"                                       : @"+1",
                                            @"Cape Verde"                                   : @"+238",
                                            @"Caribbean Netherlands"                        : @"+599",
                                            @"Cayman Islands"                               : @"+ 345",
                                            @"Central African Republic"                     : @"+236",
                                            @"Chad"                                         : @"+235",
                                            @"Chile"                                        : @"+56",
                                            @"China"                                        : @"+86",
                                            @"Christmas Island"                             : @"+61",
                                            @"Cocos (Keeling) Islands"                      : @"+61",
                                            @"Colombia"                                     : @"+57",
                                            @"Comoros"                                      : @"+269",
                                            @"Congo - Brazzaville"                          : @"+242",
                                            @"Congo - Kinshasa"                             : @"+243",
                                            @"Cook Islands"                                 : @"+682",
                                            @"Costa Rica"                                   : @"+506",
                                            @"Côte d’Ivoire"                                : @"+225",
                                            @"Croatia"                                      : @"+385",
                                            @"Cuba"                                         : @"+53",
                                            @"Curaçao"                                      : @"+599",
                                            @"Cyprus"                                       : @"+537",
                                            @"Czech Republic"                               : @"+420",
                                            @"Denmark"                                      : @"+45",
                                            @"Diego Garcia"                                 : @"+246",
                                            @"Djibouti"                                     : @"+253",
                                            @"Dominica"                                     : @"+1 767",
                                            @"Dominican Republic"                           : @"+1 809",
                                            @"Dominican Republic"                           : @"+1 829",
                                            @"Dominican Republic"                           : @"+1 849",
                                            @"East Timor"                                   : @"+670",
                                            @"Easter Island"                                : @"+56",
                                            @"Ecuador"                                      : @"+593",
                                            @"Egypt"                                        : @"+20",
                                            @"El Salvador"                                  : @"+503",
                                            @"Equatorial Guinea"                            : @"+240",
                                            @"Eritrea"                                      : @"+291",
                                            @"Estonia"                                      : @"+372",
                                            @"Ethiopia"                                     : @"+251",
                                            @"Falkland Islands"                             : @"+500",
                                            @"Faroe Islands"                                : @"+298",
                                            @"Fiji"                                         : @"+679",
                                            @"Finland"                                      : @"+358",
                                            @"France"                                       : @"+33",
                                            @"French Antilles"                              : @"+596",
                                            @"French Guiana"                                : @"+594",
                                            @"French Southern Territories"                  : @"+689",
                                            @"French Polynesia"                             : @"+689",
                                            @"Gabon"                                        : @"+241",
                                            @"Gambia"                                       : @"+220",
                                            @"Georgia"                                      : @"+995",
                                            @"Germany"                                      : @"+49",
                                            @"Ghana"                                        : @"+233",
                                            @"Gibraltar"                                    : @"+350",
                                            @"Greece"                                       : @"+30",
                                            @"Greenland"                                    : @"+299",
                                            @"Grenada"                                      : @"+1 473",
                                            @"Guadeloupe"                                   : @"+590",
                                            @"Guam"                                         : @"+1 671",
                                            @"Guatemala"                                    : @"+502",
                                            @"Guernsey"                                     : @"+44",
                                            @"Guinea"                                       : @"+224",
                                            @"Guinea-Bissau"                                : @"+245",
                                            @"Guyana"                                       : @"+595",
                                            @"Haiti"                                        : @"+509",
                                            @"Honduras"                                     : @"+504",
                                            @"Heard & McDonald Islands"                     : @"",
                                            @"Hong Kong SAR China"                          : @"+852",
                                            @"Hungary"                                      : @"+36",
                                            @"Iceland"                                      : @"+354",
                                            @"Isle of Man"                                  : @"+44",
                                            @"India"                                        : @"+91",
                                            @"Indonesia"                                    : @"+62",
                                            @"Iran"                                         : @"+98",
                                            @"Iraq"                                         : @"+964",
                                            @"Ireland"                                      : @"+353",
                                            @"Israel"                                       : @"+972",
                                            @"Italy"                                        : @"+39",
                                            @"Jamaica"                                      : @"+1 876",
                                            @"Japan"                                        : @"+81",
                                            @"Jersey"                                       : @"+44",
                                            @"Jordan"                                       : @"+962",
                                            @"Kazakhstan"                                   : @"+77",
                                            @"Kenya"                                        : @"+254",
                                            @"Kiribati"                                     : @"+686",
                                            @"North Korea"                                  : @"+850",
                                            @"South Korea"                                  : @"+82",
                                            @"Kuwait"                                       : @"+965",
                                            @"Kyrgyzstan"                                   : @"+996",
                                            @"Laos"                                         : @"+856",
                                            @"Latvia"                                       : @"+371",
                                            @"Lebanon"                                      : @"+961",
                                            @"Lesotho"                                      : @"+266",
                                            @"Liberia"                                      : @"+231",
                                            @"Libya"                                        : @"+218",
                                            @"Liechtenstein"                                : @"+423",
                                            @"Lithuania"                                    : @"+370",
                                            @"Luxembourg"                                   : @"+352",
                                            @"Macau SAR China"                              : @"+853",
                                            @"Macedonia"                                    : @"+389",
                                            @"Madagascar"                                   : @"+261",
                                            @"Malawi"                                       : @"+265",
                                            @"Malaysia"                                     : @"+60",
                                            @"Maldives"                                     : @"+960",
                                            @"Mali"                                         : @"+223",
                                            @"Malta"                                        : @"+356",
                                            @"Marshall Islands"                             : @"+692",
                                            @"Martinique"                                   : @"+596",
                                            @"Mauritania"                                   : @"+222",
                                            @"Mauritius"                                    : @"+230",
                                            @"Mayotte"                                      : @"+262",
                                            @"Mexico"                                       : @"+52",
                                            @"Micronesia"                                   : @"+691",
                                            @"Midway Island"                                : @"+1 808",
                                            @"Micronesia"                                   : @"+691",
                                            @"Moldova"                                      : @"+373",
                                            @"Monaco"                                       : @"+377",
                                            @"Mongolia"                                     : @"+976",
                                            @"Montenegro"                                   : @"+382",
                                            @"Montserrat"                                   : @"+1664",
                                            @"Morocco"                                      : @"+212",
                                            @"Mozambique"                                   : @"+258",
                                            @"Myanmar (Burma)"                              : @"+95",
                                            @"Namibia"                                      : @"+264",
                                            @"Nauru"                                        : @"+674",
                                            @"Nepal"                                        : @"+977",
                                            @"Netherlands"                                  : @"+31",
                                            @"Netherlands Antilles"                         : @"+599",
                                            @"Nevis"                                        : @"+1 869",
                                            @"New Caledonia"                                : @"+687",
                                            @"New Zealand"                                  : @"+64",
                                            @"Nicaragua"                                    : @"+505",
                                            @"Niger"                                        : @"+227",
                                            @"Nigeria"                                      : @"+234",
                                            @"Niue"                                         : @"+683",
                                            @"Norfolk Island"                               : @"+672",
                                            @"Northern Mariana Islands"                     : @"+1 670",
                                            @"Norway"                                       : @"+47",
                                            @"Oman"                                         : @"+968",
                                            @"Pakistan"                                     : @"+92",
                                            @"Palau"                                        : @"+680",
                                            @"Palestinian Territories"                      : @"+970",
                                            @"Panama"                                       : @"+507",
                                            @"Papua New Guinea"                             : @"+675",
                                            @"Paraguay"                                     : @"+595",
                                            @"Peru"                                         : @"+51",
                                            @"Philippines"                                  : @"+63",
                                            @"Pitcairn Islands"                             : @"+64",
                                            @"Poland"                                       : @"+48",
                                            @"Portugal"                                     : @"+351",
                                            @"Puerto Rico"                                  : @"+1",
                                            @"Qatar"                                        : @"+974",
                                            @"Réunion"                                      : @"+262",
                                            @"Romania"                                      : @"+40",
                                            @"Russia"                                       : @"+7",
                                            @"Rwanda"                                       : @"+250",
                                            @"Samoa"                                        : @"+685",
                                            @"San Marino"                                   : @"+378",
                                            @"Saint Barthélemy"                             : @"+590",
                                            @"São Tomé and Príncipe"                        : @"+239",
                                            @"Saint Helena"                                 : @"+290",
                                            @"Saint Kitts and Nevis"                        : @"+1 721",
                                            @"Saint Pierre and Miquelon"                    : @"+508",
                                            @"Saint Lucia"                                  : @"+1 758",
                                            @"Saudi Arabia"                                 : @"+966",
                                            @"Senegal"                                      : @"+221",
                                            @"Serbia"                                       : @"+381",
                                            @"Seychelles"                                   : @"+248",
                                            @"Sierra Leone"                                 : @"+232",
                                            @"Singapore"                                    : @"+65",
                                            @"Sint Martin"                                  : @"+1 721",
                                            @"Slovakia"                                     : @"+421",
                                            @"Slovenia"                                     : @"+386",
                                            @"Solomon Islands"                              : @"+677",
                                            @"Somalia"                                      : @"+252",
                                            @"South Africa"                                 : @"+27",
                                            @"South Sudan"                                  : @"+211",
                                            @"So. Georgia & So. Sandwich Isl."              : @"+500",
                                            @"Spain"                                        : @"+34",
                                            @"Sri Lanka"                                    : @"+94",
                                            @"St. Vincent & Grenadines"                     : @"+ 1 784 ",
                                            @"Sudan"                                        : @"+249",
                                            @"Suriname"                                     : @"+597",
                                            @"Svalbard and Jan Mayen"                       : @"+47",
                                            @"Swaziland"                                    : @"+268",
                                            @"Sweden"                                       : @"+46",
                                            @"Switzerland"                                  : @"+41",
                                            @"Syria"                                        : @"+963",
                                            @"Taiwan"                                       : @"+886",
                                            @"Tajikistan"                                   : @"+992",
                                            @"Tanzania"                                     : @"+255",
                                            @"Thailand"                                     : @"+66",
                                            @"Timor-Leste"                                  : @"+670",
                                            @"Togo"                                         : @"+228",
                                            @"Tokelau"                                      : @"+690",
                                            @"Tonga"                                        : @"+676",
                                            @"Trinidad and Tobago"                          : @"+1 868",
                                            @"Tunisia"                                      : @"+216",
                                            @"Turkey"                                       : @"+90",
                                            @"Turkmenistan"                                 : @"+993",
                                            @"Turks and Caicos Islands"                     : @"+1 649",
                                            @"Tuvalu"                                       : @"+688",
                                            @"Uganda"                                       : @"+256",
                                            @"Ukraine"                                      : @"+380",
                                            @"United Arab Emirates"                         : @"+971",
                                            @"United Kingdom"                               : @"+44",
                                            @"United States"                                : @"+1",
                                            @"Uruguay"                                      : @"+598",
                                            @"U.S. Outlying Islands"                        : @"+1",
                                            @"U.S. Virgin Islands"                          : @"+1 340",
                                            @"Uzbekistan"                                   : @"+998",
                                            @"Vanuatu"                                      : @"+678",
                                            @"Venezuela"                                    : @"+58",
                                            @"Vatican City"                                 : @"+39",
                                            @"Vietnam"                                      : @"+84",
                                            @"Wake Island"                                  : @"+1 808",
                                            @"Wallis and Futuna"                            : @"+681",
                                            @"Western Sahara"                               : @"+212",
                                            @"Yemen"                                        : @"+967",
                                            @"Zambia"                                       : @"+260",
                                            @"Zanzibar"                                     : @"+255",
                                            @"Zimbabwe"                                     : @"+263"
                                            };

            return _countryPhonesByCnode;
}

+ (NSDictionary *)countryNamesByCode
{
    static NSDictionary *_countryNamesByCode = nil;
    if (!_countryNamesByCode)
    {
        NSMutableDictionary *namesByCode = [NSMutableDictionary dictionary];
        for (NSString *code in [NSLocale ISOCountryCodes])
        {
            //NSString *countryName = [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:code];
            NSString *countryName = [[NSLocale localeWithLocaleIdentifier:@"en_US"] displayNameForKey:NSLocaleCountryCode value:code];

            //workaround for simulator bug
            if (!countryName)
            {
                countryName = [[NSLocale localeWithLocaleIdentifier:@"en_US"] displayNameForKey:NSLocaleCountryCode value:code];
            }
 
            namesByCode[code] = countryName ?: code;
        }
        _countryNamesByCode = [namesByCode copy];
    }
    return _countryNamesByCode;
}

+ (NSDictionary *)countryCodesByName
{
    static NSDictionary *_countryCodesByName = nil;
    if (!_countryCodesByName)
    {
        NSDictionary *countryNamesByCode = [self countryNamesByCode];
        NSMutableDictionary *codesByName = [NSMutableDictionary dictionary];
        for (NSString *code in countryNamesByCode)
        {
            codesByName[countryNamesByCode[code]] = code;
        }
        _countryCodesByName = [codesByName copy];
    }
    return _countryCodesByName;
}

- (void)setUp
{
    super.dataSource = self;
    super.delegate = self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}

- (void)setDataSource:(__unused id<UIPickerViewDataSource>)dataSource
{
    [self setSelectedCountryName:_countryName animated:NO];
}

- (void)setSelectedCountryCode:(NSString *)countryCode animated:(BOOL)animated
{
    NSUInteger index = [[[self class] countryCodes] indexOfObject:countryCode];
    if (index != NSNotFound)
    {
        [self selectRow:(NSInteger)index inComponent:0 animated:animated];
    }
}

- (void)setSelectedCountryCode:(NSString *)countryCode
{
    [self setSelectedCountryCode:countryCode animated:NO];
}

- (NSString *)selectedCountryCode
{
    NSUInteger index = (NSUInteger)[self selectedRowInComponent:0];
    return [[self class] countryCodes][index];
}


- (void)setSelectedCountryName:(NSString *)countryName animated:(BOOL)animated
{
    NSUInteger index = [[[self class] countryNames] indexOfObject:countryName];
    if (index != NSNotFound)
    {
        [self selectRow:(NSInteger)index inComponent:0 animated:animated];
    }
}

- (void)setSelectedCountryName:(NSString *)countryName
{
    [self setSelectedCountryName:countryName animated:NO];
}

- (NSString *)selectedCountryName
{
    NSUInteger index = (NSUInteger)[self selectedRowInComponent:0];
    return [[self class] countryNames][index];
}

- (void)setSelectedCountryPhone:(NSString *)countryPhone animated:(BOOL)animated
{
    NSUInteger index = [[[self class] countryPhones] indexOfObject:countryPhone];
    if (index != NSNotFound)
    {
        [self selectRow:(NSInteger)index inComponent:0 animated:animated];
    }
}

- (void)setSelectedCountryPhone:(NSString *)countryPhone
{
    [self setSelectedCountryPhone:countryPhone animated:NO];
}

- (NSString *)selectedCountryPhone
{
    NSUInteger index = (NSUInteger)[self selectedRowInComponent:0];
    return [[self class] countryPhones][index];
}

- (void)setSelectedLocale:(NSLocale *)locale animated:(BOOL)animated
{
    [self setSelectedCountryCode:[locale objectForKey:NSLocaleCountryCode] animated:animated];
}

- (void)setSelectedLocale:(NSLocale *)locale
{
    [self setSelectedLocale:locale animated:NO];
}

- (NSLocale *)selectedLocale
{
    NSString *countryCode = self.selectedCountryCode;
    if (countryCode)
    {
        NSString *identifier = [NSLocale localeIdentifierFromComponents:@{NSLocaleCountryCode: countryCode}];
        return [NSLocale localeWithLocaleIdentifier:identifier];
    }
    return nil;
}

#pragma mark -
#pragma mark UIPicker

- (NSInteger)numberOfComponentsInPickerView:(__unused UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(__unused UIPickerView *)pickerView numberOfRowsInComponent:(__unused NSInteger)component
{
    return (NSInteger)[[[self class] countryCodes] count];
}

- (UIView *)pickerView:(__unused UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(__unused NSInteger)component reusingView:(UIView *)view
{
   
    
    if (!view)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 200, 24)];
        name.backgroundColor = [UIColor clearColor];
        name.tag = 1;
        [view addSubview:name];
        
        UILabel *phone = [[UILabel alloc] initWithFrame:CGRectMake(240, 3, 70, 24)];
        phone.backgroundColor = [UIColor clearColor];
        phone.tag = 3;
        [view addSubview:phone];
        
        UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 24, 24)];
        flagView.contentMode = UIViewContentModeScaleAspectFit;
        flagView.tag = 2;
        [view addSubview:flagView];
    }

    ((UILabel *)[view viewWithTag:1]).text = [[self class] countryNames][(NSUInteger)row];
    ((UILabel *)[view viewWithTag:3]).text = [[self class] countryPhones][(NSUInteger)row];
    NSString *imagePath = [NSString stringWithFormat:@"CountryPicker.bundle/%@", [[self class] countryCodes][(NSUInteger) row]];
    ((UIImageView *)[view viewWithTag:2]).image = [UIImage imageNamed:imagePath];


    return view;
}

- (void)pickerView:(__unused UIPickerView *)pickerView
      didSelectRow:(__unused NSInteger)row
       inComponent:(__unused NSInteger)component
{
    __strong id<CountryPickerDelegate> strongDelegate = delegate;
    [strongDelegate countryPicker:self didSelectCountryWithName:self.selectedCountryName code:self.selectedCountryCode phone:self.selectedCountryPhone];
}

@end
