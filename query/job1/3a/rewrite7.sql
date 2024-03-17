create or replace view aggView7730555832256659520 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4876340269800710222 as select movie_id as v12 from movie_keyword as mk, aggView7730555832256659520 where mk.keyword_id=aggView7730555832256659520.v1;
create or replace view aggView3159079763227640897 as select v12 from aggJoin4876340269800710222 group by v12;
create or replace view aggJoin7025682380891095237 as select id as v12, title as v13 from title as t, aggView3159079763227640897 where t.id=aggView3159079763227640897.v12 and production_year>2005;
create or replace view aggView4484219302390430805 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin2291486439230974316 as select v13 from aggJoin7025682380891095237 join aggView4484219302390430805 using(v12);
select MIN(v13) as v24 from aggJoin2291486439230974316;
