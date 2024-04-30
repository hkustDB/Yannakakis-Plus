create or replace view aggView6609669870445513906 as select id as v12, title as v31 from title as t;
create or replace view aggJoin4527170058183516066 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView6609669870445513906 where mc.movie_id=aggView6609669870445513906.v12;
create or replace view aggView1122816488015976916 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin9211629521230635989 as select v12, v31 from aggJoin4527170058183516066 join aggView1122816488015976916 using(v1);
create or replace view aggView6598662858524254754 as select v12, MIN(v31) as v31 from aggJoin9211629521230635989 group by v12;
create or replace view aggJoin8660967787733018743 as select keyword_id as v18, v31 from movie_keyword as mk, aggView6598662858524254754 where mk.movie_id=aggView6598662858524254754.v12;
create or replace view aggView8235334629463011325 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8238155302284231378 as select v31 from aggJoin8660967787733018743 join aggView8235334629463011325 using(v18);
select MIN(v31) as v31 from aggJoin8238155302284231378;
