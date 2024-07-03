create or replace view aggView6205391891146431798 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin5860552209268616505 as select movie_id as v12 from movie_companies as mc, aggView6205391891146431798 where mc.company_id=aggView6205391891146431798.v1;
create or replace view aggView5712830899447579425 as select id as v12, title as v31 from title as t;
create or replace view aggJoin2283810476249627443 as select v12, v31 from aggJoin5860552209268616505 join aggView5712830899447579425 using(v12);
create or replace view aggView4332136324742539345 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin9023874161935360157 as select movie_id as v12 from movie_keyword as mk, aggView4332136324742539345 where mk.keyword_id=aggView4332136324742539345.v18;
create or replace view aggView1409532293064867480 as select v12, MIN(v31) as v31 from aggJoin2283810476249627443 group by v12,v31;
create or replace view aggJoin7584651176720415852 as select v31 from aggJoin9023874161935360157 join aggView1409532293064867480 using(v12);
select MIN(v31) as v31 from aggJoin7584651176720415852;
