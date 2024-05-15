create or replace view aggView3051530782556527142 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin3735612733563838553 as select movie_id as v12 from movie_companies as mc, aggView3051530782556527142 where mc.company_id=aggView3051530782556527142.v1;
create or replace view aggView5417163856420540338 as select v12 from aggJoin3735612733563838553 group by v12;
create or replace view aggJoin4427089599969989254 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView5417163856420540338 where mk.movie_id=aggView5417163856420540338.v12;
create or replace view aggView860345598520442916 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin847164211215069918 as select v12 from aggJoin4427089599969989254 join aggView860345598520442916 using(v18);
create or replace view aggView7933001715009597539 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5021501520585550510 as select v31 from aggJoin847164211215069918 join aggView7933001715009597539 using(v12);
select MIN(v31) as v31 from aggJoin5021501520585550510;
