create or replace view aggJoin7140564929879503600 as (
with aggView5161962719113930657 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView5161962719113930657 where mi_idx.info_type_id=aggView5161962719113930657.v3);
create or replace view aggJoin3265235334451121040 as (
with aggView7680945500563211538 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView7680945500563211538 where mk.keyword_id=aggView7680945500563211538.v5);
create or replace view aggJoin409833784257067033 as (
with aggView5874310899142504232 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView5874310899142504232 where t.kind_id=aggView5874310899142504232.v8 and production_year>2005);
create or replace view aggJoin1000238602424380925 as (
with aggView879647592531513689 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView879647592531513689 where mi.info_type_id=aggView879647592531513689.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin669806196047882732 as (
with aggView6799710003241952989 as (select v23 from aggJoin3265235334451121040 group by v23)
select v23, v18 from aggJoin7140564929879503600 join aggView6799710003241952989 using(v23));
create or replace view aggJoin254169065952896082 as (
with aggView5593246711809730690 as (select v18, v23 from aggJoin669806196047882732 group by v18,v23)
select v23, v18 from aggView5593246711809730690 where v18<'8.5');
create or replace view aggJoin6821789679013782378 as (
with aggView1378802048766942107 as (select v23 from aggJoin1000238602424380925 group by v23)
select v23, v24, v27 from aggJoin409833784257067033 join aggView1378802048766942107 using(v23));
create or replace view aggView2295404104969837316 as select v24, v23 from aggJoin6821789679013782378 group by v24,v23;
create or replace view aggJoin8454518769975119546 as (
with aggView1096979747335705782 as (select v23, MIN(v18) as v35 from aggJoin254169065952896082 group by v23)
select v24, v35 from aggView2295404104969837316 join aggView1096979747335705782 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin8454518769975119546;
