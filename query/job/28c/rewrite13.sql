create or replace view aggView1222275188720449248 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin2779412896264401372 as (
with aggView3400665617191003359 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView3400665617191003359 where t.kind_id=aggView3400665617191003359.v25 and production_year>2005);
create or replace view aggView5712942052395251452 as select v45, v46 from aggJoin2779412896264401372 group by v45,v46;
create or replace view aggJoin4251838599940462510 as (
with aggView1558430830955649413 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1558430830955649413 where mi_idx.info_type_id=aggView1558430830955649413.v20 and info<'8.5');
create or replace view aggJoin1863602226591492183 as (
with aggView1336237549732014481 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView1336237549732014481 where cc.subject_id=aggView1336237549732014481.v5);
create or replace view aggJoin308448028592090687 as (
with aggView5262309548038522600 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin1863602226591492183 join aggView5262309548038522600 using(v7));
create or replace view aggJoin4413519325354335310 as (
with aggView2401187215446462859 as (select v45 from aggJoin308448028592090687 group by v45)
select v45, v40 from aggJoin4251838599940462510 join aggView2401187215446462859 using(v45));
create or replace view aggJoin2993361504783121021 as (
with aggView456002259071010919 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView456002259071010919 where mk.keyword_id=aggView456002259071010919.v22);
create or replace view aggJoin526166567229079598 as (
with aggView6735392146909581584 as (select v45 from aggJoin2993361504783121021 group by v45)
select v45, v40 from aggJoin4413519325354335310 join aggView6735392146909581584 using(v45));
create or replace view aggView499985736487891298 as select v45, v40 from aggJoin526166567229079598 group by v45,v40;
create or replace view aggJoin3656824881492264993 as (
with aggView4791977193149715885 as (select v9, MIN(v10) as v57 from aggView1222275188720449248 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView4791977193149715885 where mc.company_id=aggView4791977193149715885.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1868107540803313748 as (
with aggView3067732908306258008 as (select v45, MIN(v46) as v59 from aggView5712942052395251452 group by v45)
select v45, v16, v31, v57 as v57, v59 from aggJoin3656824881492264993 join aggView3067732908306258008 using(v45));
create or replace view aggJoin3964169897298165951 as (
with aggView5342145246383057651 as (select id as v16 from company_type as ct)
select v45, v31, v57, v59 from aggJoin1868107540803313748 join aggView5342145246383057651 using(v16));
create or replace view aggJoin2919760854034674154 as (
with aggView5993694931524840460 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView5993694931524840460 where mi.info_type_id=aggView5993694931524840460.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8700743825424503527 as (
with aggView4542675323097407516 as (select v45 from aggJoin2919760854034674154 group by v45)
select v45, v31, v57 as v57, v59 as v59 from aggJoin3964169897298165951 join aggView4542675323097407516 using(v45));
create or replace view aggJoin7308620417207116841 as (
with aggView2440056821827087661 as (select v45, MIN(v57) as v57, MIN(v59) as v59 from aggJoin8700743825424503527 group by v45)
select v40, v57, v59 from aggView499985736487891298 join aggView2440056821827087661 using(v45));
select MIN(v57) as v57,MIN(v40) as v58,MIN(v59) as v59 from aggJoin7308620417207116841;
