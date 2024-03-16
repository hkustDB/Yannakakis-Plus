create or replace view aggView632952289582237267 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin8278683365267987655 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView632952289582237267 where mk.movie_id=aggView632952289582237267.v12;
create or replace view aggView2044283848461747277 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin6521361588946393523 as select v1, v24 as v24 from aggJoin8278683365267987655 join aggView2044283848461747277 using(v12);
create or replace view aggView2021284651956895834 as select v1, MIN(v24) as v24 from aggJoin6521361588946393523 group by v1;
create or replace view aggJoin7158583306804212026 as select keyword as v2, v24 from keyword as k, aggView2021284651956895834 where k.id=aggView2021284651956895834.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin7158583306804212026;
