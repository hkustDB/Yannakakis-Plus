create or replace view aggView1596832505302028569 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1805199244444143741 as select movie_id as v12 from movie_keyword as mk, aggView1596832505302028569 where mk.keyword_id=aggView1596832505302028569.v18;
create or replace view aggView1014889359365364319 as select v12 from aggJoin1805199244444143741 group by v12;
create or replace view aggJoin4208409294393708186 as select id as v12, title as v20 from title as t, aggView1014889359365364319 where t.id=aggView1014889359365364319.v12;
create or replace view aggView125300901702450349 as select v12, MIN(v20) as v31 from aggJoin4208409294393708186 group by v12;
create or replace view aggJoin631518118104751529 as select company_id as v1, v31 from movie_companies as mc, aggView125300901702450349 where mc.movie_id=aggView125300901702450349.v12;
create or replace view aggView5752254536035144026 as select v1, MIN(v31) as v31 from aggJoin631518118104751529 group by v1;
create or replace view aggJoin7789869790095904693 as select country_code as v3, v31 from company_name as cn, aggView5752254536035144026 where cn.id=aggView5752254536035144026.v1 and country_code= '[de]';
select MIN(v31) as v31 from aggJoin7789869790095904693;
