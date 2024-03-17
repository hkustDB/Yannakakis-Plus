create or replace view aggView1687185545489471135 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6845149993850803815 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView1687185545489471135 where mk.movie_id=aggView1687185545489471135.v12;
create or replace view aggView3637814063250636316 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7801388645273749169 as select v12, v31 from aggJoin6845149993850803815 join aggView3637814063250636316 using(v18);
create or replace view aggView3076040143483125989 as select v12, MIN(v31) as v31 from aggJoin7801388645273749169 group by v12;
create or replace view aggJoin1431330177238577243 as select company_id as v1, v31 from movie_companies as mc, aggView3076040143483125989 where mc.movie_id=aggView3076040143483125989.v12;
create or replace view aggView1240364753027421358 as select v1, MIN(v31) as v31 from aggJoin1431330177238577243 group by v1;
create or replace view aggJoin2560394567024036847 as select country_code as v3, v31 from company_name as cn, aggView1240364753027421358 where cn.id=aggView1240364753027421358.v1 and country_code= '[de]';
select MIN(v31) as v31 from aggJoin2560394567024036847;
