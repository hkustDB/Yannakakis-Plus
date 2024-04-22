create or replace view aggJoin3476909669867000965 as (
with aggView1585543025078958800 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView1585543025078958800 where mc.company_type_id=aggView1585543025078958800.v8);
create or replace view aggJoin1069315475029923170 as (
with aggView4146646972153458805 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView4146646972153458805 where miidx.info_type_id=aggView4146646972153458805.v10);
create or replace view aggJoin5708685009681549395 as (
with aggView2222685106380360016 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView2222685106380360016 where mi.info_type_id=aggView2222685106380360016.v12);
create or replace view aggJoin3681958358489869655 as (
with aggView5688290077309430631 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin3476909669867000965 join aggView5688290077309430631 using(v1));
create or replace view aggJoin7327024809751466640 as (
with aggView6850828278275943448 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView6850828278275943448 where t.kind_id=aggView6850828278275943448.v14);
create or replace view aggJoin6193118369217127257 as (
with aggView3229419551500715488 as (select v22, MIN(v32) as v45 from aggJoin7327024809751466640 group by v22)
select v22, v29, v45 from aggJoin1069315475029923170 join aggView3229419551500715488 using(v22));
create or replace view aggJoin6195173596707766352 as (
with aggView4449872109115357903 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin6193118369217127257 group by v22,v45)
select v22, v45, v44 from aggJoin3681958358489869655 join aggView4449872109115357903 using(v22));
create or replace view aggJoin5458076241392701259 as (
with aggView755451067979308427 as (select v22, MIN(v45) as v45, MIN(v44) as v44 from aggJoin6195173596707766352 group by v22,v44,v45)
select v24, v45, v44 from aggJoin5708685009681549395 join aggView755451067979308427 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin5458076241392701259;
