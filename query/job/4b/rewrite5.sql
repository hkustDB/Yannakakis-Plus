create or replace view aggView9048325932862961687 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin5075596074581715137 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView9048325932862961687 where mi_idx.movie_id=aggView9048325932862961687.v14 and info>'9.0';
create or replace view aggView7960099329410464543 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5408199385699798096 as select v14, v9, v27 from aggJoin5075596074581715137 join aggView7960099329410464543 using(v1);
create or replace view aggView8673587532909668418 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3331042454010592882 as select movie_id as v14 from movie_keyword as mk, aggView8673587532909668418 where mk.keyword_id=aggView8673587532909668418.v3;
create or replace view aggView3216658415632448764 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin5408199385699798096 group by v14;
create or replace view aggJoin3330682252928913685 as select v27, v26 from aggJoin3331042454010592882 join aggView3216658415632448764 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3330682252928913685;
