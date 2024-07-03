create or replace view aggView6662872321293400707 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1977042181584651213 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView6662872321293400707 where mi_idx.info_type_id=aggView6662872321293400707.v1 and info>'5.0';
create or replace view aggView6655410366043102451 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin815954795544815264 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView6655410366043102451 where mk.movie_id=aggView6655410366043102451.v14;
create or replace view aggView6228284381536500747 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1782814449354703517 as select v14, v27 from aggJoin815954795544815264 join aggView6228284381536500747 using(v3);
create or replace view aggView2898518182416747732 as select v14, MIN(v9) as v26 from aggJoin1977042181584651213 group by v14;
create or replace view aggJoin6134328664386031833 as select v27 as v27, v26 from aggJoin1782814449354703517 join aggView2898518182416747732 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin6134328664386031833;
