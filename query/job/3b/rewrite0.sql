create or replace view aggView517547299311554754 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7060704745434110154 as select movie_id as v12 from movie_keyword as mk, aggView517547299311554754 where mk.keyword_id=aggView517547299311554754.v1;
create or replace view aggView5607860903946365302 as select v12 from aggJoin7060704745434110154 group by v12;
create or replace view aggJoin5208049015056036118 as select id as v12, title as v13, production_year as v16 from title as t, aggView5607860903946365302 where t.id=aggView5607860903946365302.v12 and production_year>2010;
create or replace view aggView5655802116260007354 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin3018891202020831813 as select v13 from aggJoin5208049015056036118 join aggView5655802116260007354 using(v12);
select MIN(v13) as v24 from aggJoin3018891202020831813;
