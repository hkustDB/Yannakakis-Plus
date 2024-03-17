create or replace view aggView6823004795035827949 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5336592272828913492 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView6823004795035827949 where mc.movie_id=aggView6823004795035827949.v12;
create or replace view aggView7845349100673038908 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin8579699279463807845 as select v12, v31 from aggJoin5336592272828913492 join aggView7845349100673038908 using(v1);
create or replace view aggView4885477535856554416 as select v12, MIN(v31) as v31 from aggJoin8579699279463807845 group by v12;
create or replace view aggJoin9101950518574669701 as select keyword_id as v18, v31 from movie_keyword as mk, aggView4885477535856554416 where mk.movie_id=aggView4885477535856554416.v12;
create or replace view aggView4865254155041463756 as select v18, MIN(v31) as v31 from aggJoin9101950518574669701 group by v18;
create or replace view aggJoin6387742365027604329 as select keyword as v9, v31 from keyword as k, aggView4865254155041463756 where k.id=aggView4865254155041463756.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin6387742365027604329;
