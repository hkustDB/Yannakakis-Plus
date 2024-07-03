create or replace view aggView6037429593514527174 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin9084233334924691514 as select id as v12, title as v13, production_year as v16 from title as t, aggView6037429593514527174 where t.id=aggView6037429593514527174.v12 and production_year>2010;
create or replace view aggView921625156460825764 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8759509368850411660 as select movie_id as v12 from movie_keyword as mk, aggView921625156460825764 where mk.keyword_id=aggView921625156460825764.v1;
create or replace view aggView6170029570379735127 as select v12, MIN(v13) as v24 from aggJoin9084233334924691514 group by v12;
create or replace view aggJoin3863594264943406987 as select v24 from aggJoin8759509368850411660 join aggView6170029570379735127 using(v12);
select MIN(v24) as v24 from aggJoin3863594264943406987;
