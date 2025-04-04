create or replace view semiUp5666632261736259794 as select id as v35, site_id as v1, account_id as v50 from so_user AS u1 where (account_id) in (select (id) from account AS acc) and upvotes<=1000000 and upvotes>=1;
create or replace view semiUp7709023092462733173 as select question_id as v11, tag_id as v40, site_id as v1 from tag_question AS tq1 where (site_id, tag_id) in (select (site_id, id) from tag AS t1 where name IN ('algebra-precalculus','definite-integrals','general-topology','inequality','prime-numbers','probability','reference-request'));
create or replace view semiUp2896080339496917783 as select v11, v40, v1 from semiUp7709023092462733173 where (v11, v1) in (select (id, site_id) from question AS q1 where score<=100000 and score>=100);
create or replace view semiUp7422283211327829313 as select v11, v40, v1 from semiUp2896080339496917783 where (v1) in (select (site_id) from site AS s where site_name IN ('math','pt','serverfault'));
create or replace view semiUp5191430564255871744 as select site_id as v1, question_id as v11, owner_user_id as v35 from answer AS a1 where (question_id, site_id) in (select (v11, v1) from semiUp7422283211327829313);
create or replace view semiUp6633944411657360876 as select v35, v1, v50 from semiUp5666632261736259794 where (v1, v35) in (select (v1, v35) from semiUp5191430564255871744);
create or replace view semiUp4861679057508456163 as select site_id as v1, user_id as v35 from badge AS b where (site_id, user_id) in (select (v1, v35) from semiUp6633944411657360876) and name IN ('Announcer','Caucus','Commentator','Critic','Custodian','Editor','Enthusiast','Good Answer','Informed','Nice Answer','Nice Question','Notable Question','Organizer','Popular Question','Tumbleweed');
create or replace view semiDown2814304430290411763 as select v35, v1, v50 from semiUp6633944411657360876 where (v1, v35) in (select (v1, v35) from semiUp4861679057508456163);
create or replace view semiDown407393451022321831 as select v1, v11, v35 from semiUp5191430564255871744 where (v1, v35) in (select (v1, v35) from semiDown2814304430290411763);
create or replace view semiDown4572051841830047968 as select id as v50 from account AS acc where (id) in (select (v50) from semiDown2814304430290411763);
create or replace view semiDown4802386460053568810 as select v11, v40, v1 from semiUp7422283211327829313 where (v11, v1) in (select (v11, v1) from semiDown407393451022321831);
create or replace view semiDown292494578107960301 as select site_id as v1 from site AS s where (site_id) in (select (v1) from semiDown4802386460053568810) and site_name IN ('math','pt','serverfault');
create or replace view semiDown7654912124203966939 as select id as v40, site_id as v1 from tag AS t1 where (site_id, id) in (select (v1, v40) from semiDown4802386460053568810) and name IN ('algebra-precalculus','definite-integrals','general-topology','inequality','prime-numbers','probability','reference-request');
create or replace view semiDown3665440555425017879 as select id as v11, site_id as v1 from question AS q1 where (id, site_id) in (select (v11, v1) from semiDown4802386460053568810) and score<=100000 and score>=100;
create or replace view aggView6514213124593702768 as select v11, v1 from semiDown3665440555425017879;
create or replace view aggJoin3183561335273146585 as select v11, v40, v1 from semiDown4802386460053568810 join aggView6514213124593702768 using(v11,v1);
create or replace view aggView6276239786262198310 as select v1 from semiDown292494578107960301;
create or replace view aggJoin8542592743733344226 as select v11, v40, v1 from aggJoin3183561335273146585 join aggView6276239786262198310 using(v1);
create or replace view aggView6007414246945539598 as select v1, v40 from semiDown7654912124203966939;
create or replace view aggJoin5682569581111961394 as select v11, v1 from aggJoin8542592743733344226 join aggView6007414246945539598 using(v1,v40);
create or replace view aggView6519344484443868108 as select v11, v1, COUNT(*) as annot from aggJoin5682569581111961394 group by v11,v1;
create or replace view aggJoin4463124250941307595 as select v1, v35, annot from semiDown407393451022321831 join aggView6519344484443868108 using(v11,v1);
create or replace view aggView4905878822905943793 as select v50 from semiDown4572051841830047968;
create or replace view aggJoin1890006469391024362 as select v35, v1 from semiDown2814304430290411763 join aggView4905878822905943793 using(v50);
create or replace view aggView7714181156087229746 as select v1, v35, SUM(annot) as annot from aggJoin4463124250941307595 group by v1,v35;
create or replace view aggJoin3949905218709010720 as select v35, v1, annot from aggJoin1890006469391024362 join aggView7714181156087229746 using(v1,v35);
create or replace view aggView3960881744509399167 as select v1, v35, SUM(annot) as annot from aggJoin3949905218709010720 group by v1,v35;
create or replace view aggJoin2188967417498122601 as select annot from semiUp4861679057508456163 join aggView3960881744509399167 using(v1,v35);
select SUM(annot) as v55 from aggJoin2188967417498122601;
