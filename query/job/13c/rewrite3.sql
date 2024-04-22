create or replace view aggView1576415273916454844 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin7368515737024408013 as (
with aggView8810601889454398581 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView8810601889454398581 where miidx.info_type_id=aggView8810601889454398581.v10);
create or replace view aggView6340956785544569560 as select v22, v29 from aggJoin7368515737024408013 group by v22,v29;
create or replace view aggJoin4111873154413298926 as (
with aggView334521602385854294 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView334521602385854294 where mi.info_type_id=aggView334521602385854294.v12);
create or replace view aggJoin177006097222313952 as (
with aggView5297966843360868994 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView5297966843360868994 where t.kind_id=aggView5297966843360868994.v14 and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggJoin8345924482937686226 as (
with aggView7785707859544545049 as (select v22 from aggJoin4111873154413298926 group by v22)
select v22, v32 from aggJoin177006097222313952 join aggView7785707859544545049 using(v22));
create or replace view aggJoin7706146491736504398 as (
with aggView5926548778395631437 as (select v32, v22 from aggJoin8345924482937686226 group by v32,v22)
select v22, v32 from aggView5926548778395631437 where v32<> '');
create or replace view aggJoin6429793061605774356 as (
with aggView6867587382019023207 as (select v1, MIN(v2) as v43 from aggView1576415273916454844 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView6867587382019023207 where mc.company_id=aggView6867587382019023207.v1);
create or replace view aggJoin7082880483698122483 as (
with aggView3075278452288706860 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin6429793061605774356 join aggView3075278452288706860 using(v8));
create or replace view aggJoin3884701818756282287 as (
with aggView7184279120756227661 as (select v22, MIN(v43) as v43 from aggJoin7082880483698122483 group by v22,v43)
select v22, v29, v43 from aggView6340956785544569560 join aggView7184279120756227661 using(v22));
create or replace view aggJoin8234249690698651249 as (
with aggView8309297007850314479 as (select v22, MIN(v43) as v43, MIN(v29) as v44 from aggJoin3884701818756282287 group by v22,v43)
select v32, v43, v44 from aggJoin7706146491736504398 join aggView8309297007850314479 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin8234249690698651249;
