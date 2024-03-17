create or replace view aggView3387356340684598142 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2884679493232181722 as select movie_id as v12 from movie_keyword as mk, aggView3387356340684598142 where mk.keyword_id=aggView3387356340684598142.v18;
create or replace view aggView5543388899713079559 as select v12 from aggJoin2884679493232181722 group by v12;
create or replace view aggJoin4308090195278899166 as select id as v12, title as v20 from title as t, aggView5543388899713079559 where t.id=aggView5543388899713079559.v12;
create or replace view aggView9159288751054981813 as select v12, MIN(v20) as v31 from aggJoin4308090195278899166 group by v12;
create or replace view aggJoin3752288157468189895 as select company_id as v1, v31 from movie_companies as mc, aggView9159288751054981813 where mc.movie_id=aggView9159288751054981813.v12;
create or replace view aggView1048139248170270446 as select v1, MIN(v31) as v31 from aggJoin3752288157468189895 group by v1;
create or replace view aggJoin770268070119979922 as select country_code as v3, v31 from company_name as cn, aggView1048139248170270446 where cn.id=aggView1048139248170270446.v1 and country_code= '[nl]';
select MIN(v31) as v31 from aggJoin770268070119979922;
