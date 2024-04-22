create or replace view aggView863011818875729034 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin5373956311369139398 as (
with aggView745636574361948141 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView745636574361948141 where t.kind_id=aggView745636574361948141.v14);
create or replace view aggView6996769353233277894 as select v32, v22 from aggJoin5373956311369139398 group by v32,v22;
create or replace view aggJoin1339259019002099441 as (
with aggView1303321023367959152 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView1303321023367959152 where mi.info_type_id=aggView1303321023367959152.v12);
create or replace view aggJoin3468600133905504136 as (
with aggView6741141092695959046 as (select v22 from aggJoin1339259019002099441 group by v22)
select movie_id as v22, info_type_id as v10, info as v29 from movie_info_idx as miidx, aggView6741141092695959046 where miidx.movie_id=aggView6741141092695959046.v22);
create or replace view aggJoin2336116803735280868 as (
with aggView3744623065742048456 as (select id as v10 from info_type as it where info= 'rating')
select v22, v29 from aggJoin3468600133905504136 join aggView3744623065742048456 using(v10));
create or replace view aggView6858073873038054036 as select v22, v29 from aggJoin2336116803735280868 group by v22,v29;
create or replace view aggJoin2925423949415553285 as (
with aggView7006379026364758168 as (select v1, MIN(v2) as v43 from aggView863011818875729034 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView7006379026364758168 where mc.company_id=aggView7006379026364758168.v1);
create or replace view aggJoin344772101608469781 as (
with aggView6534789164885791081 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin2925423949415553285 join aggView6534789164885791081 using(v8));
create or replace view aggJoin6159595052642529430 as (
with aggView6010294774038631230 as (select v22, MIN(v43) as v43 from aggJoin344772101608469781 group by v22,v43)
select v32, v22, v43 from aggView6996769353233277894 join aggView6010294774038631230 using(v22));
create or replace view aggJoin3624381092179993885 as (
with aggView9090400406904738906 as (select v22, MIN(v43) as v43, MIN(v32) as v45 from aggJoin6159595052642529430 group by v22,v43)
select v29, v43, v45 from aggView6858073873038054036 join aggView9090400406904738906 using(v22));
select MIN(v43) as v43,MIN(v29) as v44,MIN(v45) as v45 from aggJoin3624381092179993885;
