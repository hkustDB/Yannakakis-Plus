create or replace view aggJoin4088083650253673110 as (
with aggView1340885279010889087 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select id as v40, title as v41, production_year as v44 from title as t, aggView1340885279010889087 where t.id=aggView1340885279010889087.v40 and production_year<=2010 and production_year>=2005);
create or replace view aggView1246100299383743819 as select v40, v41 from aggJoin4088083650253673110 group by v40,v41;
create or replace view aggJoin4188076466369419677 as (
with aggView1039300207291290794 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView1039300207291290794 where mi.info_type_id=aggView1039300207291290794.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin1085120267109126772 as (
with aggView5899013334443833304 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView5899013334443833304 where mc.company_id=aggView5899013334443833304.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin4208606000239221509 as (
with aggView68172935597419287 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin1085120267109126772 join aggView68172935597419287 using(v20));
create or replace view aggJoin3939735386885423264 as (
with aggView7534276311938358882 as (select v40 from aggJoin4208606000239221509 group by v40)
select v40, v35, v36 from aggJoin4188076466369419677 join aggView7534276311938358882 using(v40));
create or replace view aggJoin2554548162608825825 as (
with aggView3683747209379063671 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView3683747209379063671 where mk.keyword_id=aggView3683747209379063671.v24);
create or replace view aggJoin8203269275111113152 as (
with aggView5325862939127736 as (select v40 from aggJoin2554548162608825825 group by v40)
select v40, v35, v36 from aggJoin3939735386885423264 join aggView5325862939127736 using(v40));
create or replace view aggView5839335775861522761 as select v40, v35 from aggJoin8203269275111113152 group by v40,v35;
create or replace view aggJoin8036003233732937243 as (
with aggView849753995363706052 as (select v40, MIN(v41) as v53 from aggView1246100299383743819 group by v40)
select v35, v53 from aggView5839335775861522761 join aggView849753995363706052 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin8036003233732937243;
