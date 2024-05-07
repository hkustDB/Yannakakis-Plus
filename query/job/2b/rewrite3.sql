create or replace view aggView606753095705399826 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin2810987911094774016 as select movie_id as v12 from movie_companies as mc, aggView606753095705399826 where mc.company_id=aggView606753095705399826.v1;
create or replace view aggView4163669427305990874 as select v12 from aggJoin2810987911094774016 group by v12;
create or replace view aggJoin4020014656005608942 as select id as v12, title as v20 from title as t, aggView4163669427305990874 where t.id=aggView4163669427305990874.v12;
create or replace view aggView531403595472964886 as select v12, MIN(v20) as v31 from aggJoin4020014656005608942 group by v12;
create or replace view aggJoin8653090014342416274 as select keyword_id as v18, v31 from movie_keyword as mk, aggView531403595472964886 where mk.movie_id=aggView531403595472964886.v12;
create or replace view aggView7982769430677950286 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1579746035096941738 as select v31 from aggJoin8653090014342416274 join aggView7982769430677950286 using(v18);
select MIN(v31) as v31 from aggJoin1579746035096941738;
