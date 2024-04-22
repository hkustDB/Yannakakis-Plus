create or replace view aggJoin7927333056603388773 as (
with aggView5643855588168472198 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select person_id as v24, info_type_id as v16, note as v37 from person_info as pi, aggView5643855588168472198 where pi.person_id=aggView5643855588168472198.v24 and note= 'Volker Boehm');
create or replace view aggJoin1792443786992165075 as (
with aggView7271554873371327575 as (select id as v16 from info_type as it where info= 'mini biography')
select v24, v37 from aggJoin7927333056603388773 join aggView7271554873371327575 using(v16));
create or replace view aggJoin2954721824105287797 as (
with aggView1978180726158408953 as (select v24 from aggJoin1792443786992165075 group by v24)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView1978180726158408953 where n.id=aggView1978180726158408953.v24 and name_pcode_cf>='A' and name_pcode_cf<='F');
create or replace view aggJoin7040456381477300770 as (
with aggView4208795819170527501 as (select v25, v24 from aggJoin2954721824105287797 group by v25,v24)
select v24, v25 from aggView4208795819170527501 where v25 LIKE 'B%');
create or replace view aggJoin4590781196049416236 as (
with aggView8156697353997471558 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView8156697353997471558 where ml.link_type_id=aggView8156697353997471558.v18);
create or replace view aggJoin9125199923064823559 as (
with aggView8227912560319498950 as (select v38 from aggJoin4590781196049416236 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView8227912560319498950 where t.id=aggView8227912560319498950.v38 and production_year>=1980 and production_year<=1995);
create or replace view aggView5250086968703315380 as select v39, v38 from aggJoin9125199923064823559 group by v39,v38;
create or replace view aggJoin5800510319670345998 as (
with aggView5542418202168441591 as (select v24, MIN(v25) as v50 from aggJoin7040456381477300770 group by v24)
select movie_id as v38, v50 from cast_info as ci, aggView5542418202168441591 where ci.person_id=aggView5542418202168441591.v24);
create or replace view aggJoin5935037935952112366 as (
with aggView8225150870842714382 as (select v38, MIN(v50) as v50 from aggJoin5800510319670345998 group by v38,v50)
select v39, v50 from aggView5250086968703315380 join aggView8225150870842714382 using(v38));
select MIN(v50) as v50,MIN(v39) as v51 from aggJoin5935037935952112366;
