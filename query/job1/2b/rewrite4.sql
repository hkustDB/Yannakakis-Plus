create or replace view aggView4182447049441726979 as select id as v12, title as v31 from title as t;
create or replace view aggJoin1324320945733179841 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView4182447049441726979 where mk.movie_id=aggView4182447049441726979.v12;
create or replace view aggView6942152603369339904 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5190800160744249641 as select v12, v31 from aggJoin1324320945733179841 join aggView6942152603369339904 using(v18);
create or replace view aggView9219530790057835911 as select v12, MIN(v31) as v31 from aggJoin5190800160744249641 group by v12;
create or replace view aggJoin2415943558127332935 as select company_id as v1, v31 from movie_companies as mc, aggView9219530790057835911 where mc.movie_id=aggView9219530790057835911.v12;
create or replace view aggView7270748041209229806 as select v1, MIN(v31) as v31 from aggJoin2415943558127332935 group by v1;
create or replace view aggJoin5167697439944017295 as select country_code as v3, v31 from company_name as cn, aggView7270748041209229806 where cn.id=aggView7270748041209229806.v1 and country_code= '[nl]';
select MIN(v31) as v31 from aggJoin5167697439944017295;
