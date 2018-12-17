//
//  RapKeyboard.swift
//  TastyImitationKeyboard
//
//  Created by Marcin Mierzejewski on 23/05/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit



class Rapboard: KeyboardViewController {
    
    let textChecker: UITextChecker = UITextChecker();
    let rhymesView : VERhymesView = VERhymesView();
    let keyboardSettingsView : VEKeyboardSettingsView = VEKeyboardSettingsView();

    var lexicon: UILexicon!;
    let takeDebugScreenshot: Bool = false
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.addSubview(rhymesView);
        self.view.addSubview(keyboardSettingsView);
        
        self.requestSupplementaryLexicon { (lexicon) in
            self.lexicon = lexicon;
        }
    }
    
    override func keyPressed(_ key: Key) {
        let textDocumentProxy = self.textDocumentProxy
        
        let keyOutput = key.outputForCase(self.shiftState.uppercase())
        
        if key.type == .character || key.type == .specialCharacter {
            if let context = textDocumentProxy.documentContextBeforeInput {
                
                var index = context.endIndex
                
                index = context.index(before: index)
                if context[index] != " " {
                    textDocumentProxy.insertText(keyOutput)
                    return
                }
                
                index = context.index(before: index)
                if context[index] == " " {
                    textDocumentProxy.insertText(keyOutput)
                    return
                }
                
                textDocumentProxy.insertText(" ")
                textDocumentProxy.insertText(keyOutput)
                return
            }
            else {
                textDocumentProxy.insertText(keyOutput)
                return
            }
        } else {
            
            if key.type == .space {
                var lastWord = self.textDocumentProxy.documentContextBeforeInput;
                
                var array = lastWord?.components(separatedBy: NSCharacterSet.whitespaces);
                array = array?.filter({ (word) -> Bool in
                    return word.count>0
                });
                if array!.count > 0 {
                    lastWord = array?.last;
                    if !self.isDictionaryWord(word: lastWord!) {
                        let lastWordRange = NSMakeRange(0, lastWord!.count);
                        
                        let guesses = self.textChecker.guesses(forWordRange: lastWordRange, in: lastWord!, language: "en_US") //guessesForWordRange:lastWordRange inString:lastWord language:@"en_US"];
                        if(guesses!.count > 0) {
                            for _ in lastWord! {
                                self.textDocumentProxy.deleteBackward();
                            }
                            
                            if let firstGuess = guesses?.first {
                                self.textDocumentProxy.insertText(firstGuess)
                            }
                        }
                    }
                }

            }
            
            textDocumentProxy.insertText(keyOutput)
            return
        }
    }
    
    func isDictionaryWord(word: String!) -> Bool {
        for lexiconEntry in self.lexicon.entries {
            if word.caseInsensitiveCompare(lexiconEntry.documentText) == .orderedSame {
                return true;
            }
        }
    
        let currentLanguage = "en_US";
        let searchRange = NSMakeRange(0, word.count);
        
        
        let misspelledRange = self.textChecker.rangeOfMisspelledWord(in: word, range: searchRange, startingAt: 0, wrap: false, language: currentLanguage);
        return misspelledRange.location == NSNotFound;
    
    }

    
    override func setupKeys() {
        super.setupKeys()
    }
    
    
    
}

