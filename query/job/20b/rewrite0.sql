create or replace view aggJoin7889925988464715654 as (
with aggView5624185557474281692 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView5624185557474281692 where t.kind_id=aggView5624185557474281692.v26 and production_year>2000);
create or replace view aggJoin2522305599756636886 as (
with aggView9150713070718851013 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView9150713070718851013 where ci.person_role_id=aggView9150713070718851013.v9);
create or replace view aggJoin1351190862933990083 as (
with aggView1260868765754677333 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin2522305599756636886 join aggView1260868765754677333 using(v31));
create or replace view aggJoin6630582578419757314 as (
with aggView4511281577665255470 as (select v40 from aggJoin1351190862933990083 group by v40)
select movie_id as v40, subject_id as v5, status_id as v7 from complete_cast as cc, aggView4511281577665255470 where cc.movie_id=aggView4511281577665255470.v40);
create or replace view aggJoin5378299450606679262 as (
with aggView8734535163404938544 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40, v5 from aggJoin6630582578419757314 join aggView8734535163404938544 using(v7));
create or replace view aggJoin4950938953943299606 as (
with aggView9024414653978096971 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin5378299450606679262 join aggView9024414653978096971 using(v5));
create or replace view aggJoin315253784312253732 as (
with aggView8452968487833144573 as (select v40 from aggJoin4950938953943299606 group by v40)
select v40, v41, v44 from aggJoin7889925988464715654 join aggView8452968487833144573 using(v40));
create or replace view aggJoin4241998105165951300 as (
with aggView8836969304184695965 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView8836969304184695965 where mk.keyword_id=aggView8836969304184695965.v23);
create or replace view aggJoin3106039527085475635 as (
with aggView7694637332314689032 as (select v40 from aggJoin4241998105165951300 group by v40)
select v41, v44 from aggJoin315253784312253732 join aggView7694637332314689032 using(v40));
create or replace view aggView2014209211528651530 as select v41 from aggJoin3106039527085475635 group by v41;
select MIN(v41) as v52 from aggView2014209211528651530;
