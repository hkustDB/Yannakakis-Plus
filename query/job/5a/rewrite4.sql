create or replace view aggView5544499752802187884 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin2105740388856234322 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView5544499752802187884 where mc.movie_id=aggView5544499752802187884.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView7340063000111413612 as select id as v3 from info_type as it;
create or replace view aggJoin5425455558118116574 as select movie_id as v15, info as v13 from movie_info as mi, aggView7340063000111413612 where mi.info_type_id=aggView7340063000111413612.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2277165486141709787 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7493532763288760934 as select v15, v9, v27 from aggJoin2105740388856234322 join aggView2277165486141709787 using(v1);
create or replace view aggView5588293230614417589 as select v15, MIN(v27) as v27 from aggJoin7493532763288760934 group by v15,v27;
create or replace view aggJoin5911136358599304479 as select v27 from aggJoin5425455558118116574 join aggView5588293230614417589 using(v15);
select MIN(v27) as v27 from aggJoin5911136358599304479;
