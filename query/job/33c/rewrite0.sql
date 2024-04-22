create or replace view aggView8532189222238611425 as select name as v2, id as v1 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView5380764101724638792 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggJoin1047243182880350895 as (
with aggView3912911972081511972 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView3912911972081511972 where mi_idx2.info_type_id=aggView3912911972081511972.v17);
create or replace view aggJoin798793246699871125 as (
with aggView2651467373109259923 as (select v61, v43 from aggJoin1047243182880350895 group by v61,v43)
select v61, v43 from aggView2651467373109259923 where v43<'3.5');
create or replace view aggJoin1199109027797045307 as (
with aggView1405219595740410420 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView1405219595740410420 where t2.kind_id=aggView1405219595740410420.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView6244187620862391431 as select v61, v62 from aggJoin1199109027797045307 group by v61,v62;
create or replace view aggJoin2864884288299654154 as (
with aggView4057524412313327176 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView4057524412313327176 where t1.kind_id=aggView4057524412313327176.v19);
create or replace view aggView6552654986986870141 as select v50, v49 from aggJoin2864884288299654154 group by v50,v49;
create or replace view aggJoin818999481893877847 as (
with aggView277673406916859706 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView277673406916859706 where mi_idx1.info_type_id=aggView277673406916859706.v15);
create or replace view aggView2837424709481739056 as select v38, v49 from aggJoin818999481893877847 group by v38,v49;
create or replace view aggJoin2831897031234813283 as (
with aggView4908158344581552399 as (select v49, MIN(v50) as v77 from aggView6552654986986870141 group by v49)
select movie_id as v49, company_id as v1, v77 from movie_companies as mc1, aggView4908158344581552399 where mc1.movie_id=aggView4908158344581552399.v49);
create or replace view aggJoin83129560243254302 as (
with aggView3996725509254562382 as (select v8, MIN(v9) as v74 from aggView5380764101724638792 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView3996725509254562382 where mc2.company_id=aggView3996725509254562382.v8);
create or replace view aggJoin800723143696500744 as (
with aggView2936147370020246860 as (select v61, MIN(v43) as v76 from aggJoin798793246699871125 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v76 from movie_link as ml, aggView2936147370020246860 where ml.linked_movie_id=aggView2936147370020246860.v61);
create or replace view aggJoin4292827829474379867 as (
with aggView2835148161900992906 as (select v61, MIN(v62) as v78 from aggView6244187620862391431 group by v61)
select v61, v74 as v74, v78 from aggJoin83129560243254302 join aggView2835148161900992906 using(v61));
create or replace view aggJoin6249059554228601056 as (
with aggView6255911949443044973 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v76 from aggJoin800723143696500744 join aggView6255911949443044973 using(v23));
create or replace view aggJoin7711899854053746546 as (
with aggView7318470001292949407 as (select v61, MIN(v74) as v74, MIN(v78) as v78 from aggJoin4292827829474379867 group by v61,v74,v78)
select v49, v76 as v76, v74, v78 from aggJoin6249059554228601056 join aggView7318470001292949407 using(v61));
create or replace view aggJoin409260421840919947 as (
with aggView8099308608978568960 as (select v49, MIN(v76) as v76, MIN(v74) as v74, MIN(v78) as v78 from aggJoin7711899854053746546 group by v49,v74,v76,v78)
select v38, v49, v76, v74, v78 from aggView2837424709481739056 join aggView8099308608978568960 using(v49));
create or replace view aggJoin1060037783873042366 as (
with aggView6644045184996826627 as (select v49, MIN(v76) as v76, MIN(v74) as v74, MIN(v78) as v78, MIN(v38) as v75 from aggJoin409260421840919947 group by v49,v74,v76,v78)
select v1, v77 as v77, v76, v74, v78, v75 from aggJoin2831897031234813283 join aggView6644045184996826627 using(v49));
create or replace view aggJoin3668730142585651168 as (
with aggView5506347328736481222 as (select v1, MIN(v77) as v77, MIN(v76) as v76, MIN(v74) as v74, MIN(v78) as v78, MIN(v75) as v75 from aggJoin1060037783873042366 group by v1,v75,v76,v74,v77,v78)
select v2, v77, v76, v74, v78, v75 from aggView8532189222238611425 join aggView5506347328736481222 using(v1));
select MIN(v2) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin3668730142585651168;
