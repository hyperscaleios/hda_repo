from flask import Flask, render_template, flash, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from app import app
from app.forms import LoginForm
from loguru import logger
import sys
import logging
import psycopg2


@app.route('/')
def index():
    logger.debug('hello from logger in route.py  @app.route(\'/\') -> def index()')
    return render_template('index.html', customers=customers)



@app.route('/docs_page')
def docs_page():
    return render_template('docs_page.html')

@app.route('/about')
def about():
    user = {'username':'Allison'}
    return render_template('about.html', title='HSIO', user=user)

@app.route('/allison')
def allison():
    user = {'username':'Allison'}
    return render_template('allison.html', title='HSIO', user=user)

@app.route('/dongdidong')
def dongdidong():
    user = {'username':'DongDiDong'}
    return render_template('dongdidong.html', title='HSIO', user=user)

@app.route('/michelle')
def michelle():
    user = {'username':'Michelle'}
    return render_template('michelle.html', title='HSIO', user=user)

@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        flash('Login requested for user {}, remember_me={}'.format(form.username.data, form.remember_me.data))
        return redirect( url_for('index') )
    return render_template('login.html', title='Sign In', form=form)

logger.add("hda_portal.log",rotation="4 KB")
logger.info("starting hda_portal")

if __name__ == '__main__':
    app.run(debug=True)
