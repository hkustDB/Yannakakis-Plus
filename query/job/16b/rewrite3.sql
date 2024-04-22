create or replace view aggJoin132596208718252123 as (
with aggView7479133690698041098 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView7479133690698041098 where mk.keyword_id=aggView7479133690698041098.v33);
create or replace view aggJoin401643449238560807 as (
with aggView8997889743164097817 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView8997889743164097817 where an.person_id=aggView8997889743164097817.v2);
create or replace view aggView4769507635192422900 as select v3, v2 from aggJoin401643449238560807 group by v3,v2;
create or replace view aggJoin3536147271468202501 as (
with aggView1280264127120061135 as (select v11 from aggJoin132596208718252123 group by v11)
select id as v11, title as v44 from title as t, aggView1280264127120061135 where t.id=aggView1280264127120061135.v11);
create or replace view aggView2700993578904928322 as select v44, v11 from aggJoin3536147271468202501 group by v44,v11;
create or replace view aggJoin636712425993892621 as (
with aggView907430161047850149 as (select v11, MIN(v44) as v56 from aggView2700993578904928322 group by v11)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView907430161047850149 where ci.movie_id=aggView907430161047850149.v11);
create or replace view aggJoin1149685431811734419 as (
with aggView3771074272565070935 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView3771074272565070935 where mc.company_id=aggView3771074272565070935.v28);
create or replace view aggJoin5910401480602739556 as (
with aggView1298299817948325308 as (select v11 from aggJoin1149685431811734419 group by v11)
select v2, v56 as v56 from aggJoin636712425993892621 join aggView1298299817948325308 using(v11));
create or replace view aggJoin2162411565886668809 as (
with aggView3946869445926786573 as (select v2, MIN(v56) as v56 from aggJoin5910401480602739556 group by v2,v56)
select v3, v56 from aggView4769507635192422900 join aggView3946869445926786573 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin2162411565886668809;
