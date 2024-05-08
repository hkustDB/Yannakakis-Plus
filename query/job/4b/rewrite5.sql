create or replace view aggView6103756161522356322 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin4466815332383399011 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView6103756161522356322 where mi_idx.movie_id=aggView6103756161522356322.v14 and info>'9.0';
create or replace view aggView8024418820432766596 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7540481041930237140 as select movie_id as v14 from movie_keyword as mk, aggView8024418820432766596 where mk.keyword_id=aggView8024418820432766596.v3;
create or replace view aggView3128723778085295217 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3338065794641618001 as select v14, v9, v27 from aggJoin4466815332383399011 join aggView3128723778085295217 using(v1);
create or replace view aggView2544290209315228785 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin3338065794641618001 group by v14;
create or replace view aggJoin2949207867810808285 as select v27, v26 from aggJoin7540481041930237140 join aggView2544290209315228785 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2949207867810808285;
