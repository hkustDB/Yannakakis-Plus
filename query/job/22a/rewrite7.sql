create or replace view aggView7268518156396283083 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin5389072004179497166 as (
with aggView5254346647519015006 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView5254346647519015006 where mi_idx.info_type_id=aggView5254346647519015006.v12 and info<'7.0');
create or replace view aggJoin9154713932339512884 as (
with aggView2156623073349597294 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView2156623073349597294 where t.kind_id=aggView2156623073349597294.v17 and production_year>2008);
create or replace view aggView1668256168703894158 as select v38, v37 from aggJoin9154713932339512884 group by v38,v37;
create or replace view aggJoin1096017397702610208 as (
with aggView539197524028578721 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView539197524028578721 where mi.info_type_id=aggView539197524028578721.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin4992303889813056378 as (
with aggView308407997869245263 as (select v37 from aggJoin1096017397702610208 group by v37)
select movie_id as v37, keyword_id as v14 from movie_keyword as mk, aggView308407997869245263 where mk.movie_id=aggView308407997869245263.v37);
create or replace view aggJoin3106409573515548919 as (
with aggView7702647977657778608 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v37 from aggJoin4992303889813056378 join aggView7702647977657778608 using(v14));
create or replace view aggJoin6094496583364496725 as (
with aggView2587358355201060919 as (select v37 from aggJoin3106409573515548919 group by v37)
select v37, v32 from aggJoin5389072004179497166 join aggView2587358355201060919 using(v37));
create or replace view aggView5028338137883556472 as select v32, v37 from aggJoin6094496583364496725 group by v32,v37;
create or replace view aggJoin6935858210519730590 as (
with aggView3492182102356565878 as (select v1, MIN(v2) as v49 from aggView7268518156396283083 group by v1)
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView3492182102356565878 where mc.company_id=aggView3492182102356565878.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin5532386617954575066 as (
with aggView2107877089708155973 as (select v37, MIN(v32) as v50 from aggView5028338137883556472 group by v37)
select v37, v8, v23, v49 as v49, v50 from aggJoin6935858210519730590 join aggView2107877089708155973 using(v37));
create or replace view aggJoin8295789073990539577 as (
with aggView4546703259815254547 as (select id as v8 from company_type as ct)
select v37, v23, v49, v50 from aggJoin5532386617954575066 join aggView4546703259815254547 using(v8));
create or replace view aggJoin6051183886095302946 as (
with aggView4697176064894611774 as (select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin8295789073990539577 group by v37,v49,v50)
select v38, v49, v50 from aggView1668256168703894158 join aggView4697176064894611774 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v38) as v51 from aggJoin6051183886095302946;
