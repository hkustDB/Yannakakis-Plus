create or replace view aggView8000111409843242213 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin4834597392408171160 as select movie_id as v12 from movie_companies as mc, aggView8000111409843242213 where mc.company_id=aggView8000111409843242213.v1;
create or replace view aggView6031888926603156340 as select v12 from aggJoin4834597392408171160 group by v12;
create or replace view aggJoin6118804483492203905 as select id as v12, title as v20 from title as t, aggView6031888926603156340 where t.id=aggView6031888926603156340.v12;
create or replace view aggView7381488312916683742 as select v12, MIN(v20) as v31 from aggJoin6118804483492203905 group by v12;
create or replace view aggJoin6057105204427990770 as select keyword_id as v18, v31 from movie_keyword as mk, aggView7381488312916683742 where mk.movie_id=aggView7381488312916683742.v12;
create or replace view aggView3973707426959054376 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6308724048842160585 as select v31 from aggJoin6057105204427990770 join aggView3973707426959054376 using(v18);
select MIN(v31) as v31 from aggJoin6308724048842160585;
