create or replace view aggView4796123519668173343 as select id as v12 from title as t;
create or replace view aggJoin7598571558358548491 as select movie_id as v12, company_id as v1 from movie_companies as mc, aggView4796123519668173343 where mc.movie_id=aggView4796123519668173343.v12;
create or replace view aggView8753355615955591032 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin6435956973235588204 as select v12 from aggJoin7598571558358548491 join aggView8753355615955591032 using(v1);
create or replace view aggView8491231564687463493 as select v12, COUNT(*) as annot from aggJoin6435956973235588204 group by v12;
create or replace view aggJoin6521842163134700239 as select keyword_id as v18, annot from movie_keyword as mk, aggView8491231564687463493 where mk.movie_id=aggView8491231564687463493.v12;
create or replace view aggView368384169430557704 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin290272290098243813 as select annot from aggJoin6521842163134700239 join aggView368384169430557704 using(v18);
select SUM(annot) as v31 from aggJoin290272290098243813;
