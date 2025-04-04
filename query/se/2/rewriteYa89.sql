create or replace view semiUp1839074833139308508 as select question_id as v17, tag_id as v11, site_id as v1 from tag_question AS tq1 where (tag_id, site_id) in (select (id, site_id) from tag AS t1 where name IN ('angular-dart','cells','distutils','exchange-server','graphviz','layer','outlook-addin','prism','spark-dataframe','spring-security-oauth2','statusbar'));
create or replace view semiUp2348154631161605728 as select id as v17, site_id as v1, owner_user_id as v25 from question AS q1 where (owner_user_id, site_id) in (select (user_id, site_id) from badge AS b1) and view_count>=1 and view_count<=10000000;
create or replace view semiUp7426625369681035912 as select v17, v1, v25 from semiUp2348154631161605728 where (v1) in (select (site_id) from site AS s where site_name= 'stackoverflow');
create or replace view semiUp6902530552495378707 as select id as v25, site_id as v1, account_id as v37 from so_user AS u1 where (account_id) in (select (id) from account AS acc);
create or replace view semiUp8363657789609177576 as select v17, v1, v25 from semiUp7426625369681035912 where (v25, v1) in (select (v25, v1) from semiUp6902530552495378707);
create or replace view semiUp6300333044092429443 as select v17, v11, v1 from semiUp1839074833139308508 where (v17, v1) in (select (v17, v1) from semiUp8363657789609177576);
create or replace view semiDown4420318716809414416 as select id as v11, site_id as v1 from tag AS t1 where (id, site_id) in (select (v11, v1) from semiUp6300333044092429443) and name IN ('angular-dart','cells','distutils','exchange-server','graphviz','layer','outlook-addin','prism','spark-dataframe','spring-security-oauth2','statusbar');
create or replace view semiDown5265303405562150919 as select v17, v1, v25 from semiUp8363657789609177576 where (v17, v1) in (select (v17, v1) from semiUp6300333044092429443);
create or replace view semiDown164850909024996505 as select site_id as v1 from site AS s where (site_id) in (select (v1) from semiDown5265303405562150919) and site_name= 'stackoverflow';
create or replace view semiDown1192431468260458830 as select v25, v1, v37 from semiUp6902530552495378707 where (v25, v1) in (select (v25, v1) from semiDown5265303405562150919);
create or replace view semiDown1548190893628647537 as select site_id as v1, user_id as v25 from badge AS b1 where (user_id, site_id) in (select (v25, v1) from semiDown5265303405562150919);
create or replace view semiDown5875565316009727589 as select id as v37 from account AS acc where (id) in (select (v37) from semiDown1192431468260458830);
create or replace view aggView2496458135200833675 as select v37 from semiDown5875565316009727589;
create or replace view aggJoin440121055331215256 as select v25, v1 from semiDown1192431468260458830 join aggView2496458135200833675 using(v37);
create or replace view aggView4096664280198488526 as select v25, v1, COUNT(*) as annot from aggJoin440121055331215256 group by v25,v1;
create or replace view aggJoin5061095220605092188 as select v17, v1, v25, annot from semiDown5265303405562150919 join aggView4096664280198488526 using(v25,v1);
create or replace view aggView6430268968290789026 as select v1 from semiDown164850909024996505;
create or replace view aggJoin4168368488871595546 as select v17, v1, v25, annot from aggJoin5061095220605092188 join aggView6430268968290789026 using(v1);
create or replace view aggView2440337190050797122 as select v25, v1 from semiDown1548190893628647537;
create or replace view aggJoin3663198630102136631 as select v17, v1, annot from aggJoin4168368488871595546 join aggView2440337190050797122 using(v25,v1);
create or replace view aggView6331771980448109753 as select v17, v1, SUM(annot) as annot from aggJoin3663198630102136631 group by v17,v1;
create or replace view aggJoin2225893284582135767 as select v11, v1, annot from semiUp6300333044092429443 join aggView6331771980448109753 using(v17,v1);
create or replace view aggView3840636295736632936 as select v11, v1 from semiDown4420318716809414416;
create or replace view aggJoin7623359986077167563 as select annot from aggJoin2225893284582135767 join aggView3840636295736632936 using(v11,v1);
select SUM(annot) as v42 from aggJoin7623359986077167563;
