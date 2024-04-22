create or replace view aggView1435697315264685024 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin4763760301042179004 as (
with aggView877043197706990797 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Germany','Swedish','German') group by movie_id)
select movie_id as v37, subject_id as v5, status_id as v7 from complete_cast as cc, aggView877043197706990797 where cc.movie_id=aggView877043197706990797.v37);
create or replace view aggJoin1539005329127071 as (
with aggView4822119894704091161 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v37, v7 from aggJoin4763760301042179004 join aggView4822119894704091161 using(v5));
create or replace view aggJoin6930065099643299928 as (
with aggView212484858158782706 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView212484858158782706 where mk.keyword_id=aggView212484858158782706.v35);
create or replace view aggJoin5027327444061666997 as (
with aggView5005165103512159959 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin1539005329127071 join aggView5005165103512159959 using(v7));
create or replace view aggJoin9195265932140689603 as (
with aggView9106439554936148716 as (select v37 from aggJoin5027327444061666997 group by v37)
select id as v37, title as v41, production_year as v44 from title as t, aggView9106439554936148716 where t.id=aggView9106439554936148716.v37 and production_year= 1998);
create or replace view aggJoin1804790044162077097 as (
with aggView7848590469280979831 as (select v37 from aggJoin6930065099643299928 group by v37)
select v37, v41, v44 from aggJoin9195265932140689603 join aggView7848590469280979831 using(v37));
create or replace view aggView3912089225371577292 as select v37, v41 from aggJoin1804790044162077097 group by v37,v41;
create or replace view aggJoin6431880608557312908 as (
with aggView6226048314621310046 as (select v25, MIN(v10) as v52 from aggView1435697315264685024 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView6226048314621310046 where mc.company_id=aggView6226048314621310046.v25);
create or replace view aggJoin7918346746892841704 as (
with aggView8849276863347697691 as (select v37, MIN(v41) as v54 from aggView3912089225371577292 group by v37)
select v37, v26, v52 as v52, v54 from aggJoin6431880608557312908 join aggView8849276863347697691 using(v37));
create or replace view aggJoin7706565707272843448 as (
with aggView4777250166123962947 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52, v54 from aggJoin7918346746892841704 join aggView4777250166123962947 using(v26));
create or replace view aggJoin2549650420958781711 as (
with aggView7045707055601908972 as (select v37, MIN(v52) as v52, MIN(v54) as v54 from aggJoin7706565707272843448 group by v37,v52,v54)
select link_type_id as v21, v52, v54 from movie_link as ml, aggView7045707055601908972 where ml.movie_id=aggView7045707055601908972.v37);
create or replace view aggJoin6872863742854721338 as (
with aggView1468273132123068780 as (select v21, MIN(v52) as v52, MIN(v54) as v54 from aggJoin2549650420958781711 group by v21,v52,v54)
select link as v22, v52, v54 from link_type as lt, aggView1468273132123068780 where lt.id=aggView1468273132123068780.v21 and link LIKE '%follow%');
select MIN(v52) as v52,MIN(v22) as v53,MIN(v54) as v54 from aggJoin6872863742854721338;
